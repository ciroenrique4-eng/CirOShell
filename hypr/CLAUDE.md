# Hyprland Config — Contexto del sistema

## Hardware

- **CPU:** Intel Core i5-13450HX (Raptor Lake-S, 13ª gen)
- **iGPU:** Intel UHD Graphics (i915) — driver: `iris`
- **dGPU:** NVIDIA GeForce RTX 4050 Laptop GPU — driver: `nvidia-open 615.71.09`
- **RAM:** 16 GB
- **Pantalla:** eDP-1, 1920×1080 @ 120Hz fijos (sin VRR/Adaptive Sync hardware)
- **Kernel:** CachyOS (linux-cachyos)
- **Compositor:** Hyprland 0.56.2 en Wayland (con Xwayland)
- **Formato de config:** Lua (`hyprland.lua` + `hyprland/*.lua`). La sintaxis `.conf`
  antigua (`source =`, `bind =`, `windowrule =`) ya no se usa aquí.

## Arquitectura GPU (Optimus / PRIME)

El laptop usa **NVIDIA Optimus**: la pantalla interna está físicamente conectada a la Intel iGPU, no a la NVIDIA.

```
/dev/dri/card1  →  Intel iGPU        (renderD128, tiene eDP-1)  vendor: 0x8086
/dev/dri/card2  →  NVIDIA RTX 4050   (renderD129)               vendor: 0x10de
```

> Verificado con `cat /sys/class/drm/cardN/device/vendor`. El mapeo previo estaba al revés.

`WLR_DRM_DEVICES` apunta a `card1` (Intel): Hyprland compone en Intel. La NVIDIA queda disponible para offload via `prime-run`. Este es el modo **Híbrido** estándar (Optimus), **no** Reverse PRIME.

El modo **GPU Mode** script permite cambiar entre:
- **Integrada**: `WLR_DRM_DEVICES=card1`, NVIDIA en standby (ahorra batería)
- **Híbrida**: `WLR_DRM_DEVICES=card1`, NVIDIA disponible para offload (modo actual)
- **NVIDIA (Reverse PRIME)**: `WLR_DRM_DEVICES=card2`, compositor en dGPU, copia PRIME a Intel

**Flujo en modo Reverse PRIME (juegos):**
```
NVIDIA VRAM → PCIe → RAM sistema → Intel iGPU → pantalla
```

### PCIe

- Enlace máximo: Gen 4 x8 (~16 GB/s)
- Enlace en reposo: Gen 2 (~4 GB/s) — el power management lo baja
- Se añadió udev rule en `/etc/udev/rules.d/99-nvidia-pcie.rules` para mantenerlo en Gen 4

### Por qué el modo "solo dGPU desde BIOS" funciona perfecto

Cuando se activa discrete-only desde BIOS, la pantalla se conecta directamente a NVIDIA → no hay copia PRIME → cero overhead. Contrapartida: consume mucha más batería y usa VRAM de la GPU dedicada permanentemente.

## Estado de módulos

- `nvidia-drm.modeset=1` — **activo** (verificado: `/sys/module/nvidia_drm/parameters/modeset` = Y)
- No hay `/etc/modprobe.d/nvidia*.conf` — el modeset viene del bootloader/initramfs

## Configuración relevante

### env.lua — GPU/NVIDIA

La sección GPU se gestiona dinámicamente mediante `env_gpu.lua` (no editar a mano):

```lua
-- En env.lua. pcall: si el archivo aún no existe, la sesión arranca igual.
pcall(require, "hyprland.env_gpu")
```

El archivo `env_gpu.lua` lo escribe el script `scripts/󰢮 GPU Mode.sh`. Ejemplo del modo híbrido:

```lua
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")            -- mejor decodificación HW con ffmpeg/mpv
hl.env("__GL_GSYNC_ALLOWED", "1")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")     -- evita bugs de cursor con NVIDIA en Wayland
hl.env("WLR_DRM_DEVICES", "/dev/dri/card1") -- card1=Intel, card2=NVIDIA
```

> `__GL_GSYNC_ALLOWED` y `__GL_VRR_ALLOWED` aplican principalmente a X11/GLX, no a Wayland nativo. En Wayland el VRR lo controla `vrr` en `misc.lua`.

### hyprland.lua — nivel raíz

El `.conf` viejo traía `explicit_sync = 2` y `unscale_layers = true` a nivel raíz.
**Ninguna de las dos existe en Hyprland 0.56** (`hyprctl getoption` responde `no such
option`), así que no se portaron: llevaban tiempo sin hacer nada.

### misc.lua

```lua
misc = { vrr = 0 }                 -- 0=off, 1=siempre, 2=solo fullscreen
render = { direct_scanout = 1 }    -- fullscreen solitario directo al plano del display
```

La pantalla no tiene VRR hardware y con `vrr` activo parpadea → queda en `0`.

`direct_scanout` saca al compositor del camino cuando hay una única ventana
fullscreen: medido, Hyprland pasa de 14.9% a 7.5% de CPU, de 23.1% a 0% de GPU y de
9.0W a 3.4W. Requiere **fullscreen real**, no ventana sin bordes. Verificar con:

```bash
hyprctl monitors | grep -E "solitary|tearing|directScanout"
```

Si aparece `user settings` en los `*BlockedBy`, el flag está apagado. `missing
candidate` o `windowed mode` es normal en escritorio: solo significa que no hay un
fullscreen activo.

### rules.lua — juegos

Las reglas van por **tags**: se etiquetan los matches y al final se define qué hace
cada tag. Las definiciones (`create_tag`) tienen que ir **después** de todos los usos.

```lua
tagged_rule(game_tag, { "steam_app_[0-9]+", "steam_app_default", "gamescope" })
-- ...
create_tag(game_tag, { immediate = true, idle_inhibit = "always" })
```

`immediate = true` permite tearing (frames sin esperar vblank). Requiere
`allow_tearing = true` en `general.lua`, que ya está activo.

## Problema de stutter en juegos

**Síntoma:** el juego rinde bien en FPS pero la pantalla se ve trabada/stuttering.

**Causa raíz:** la arquitectura PRIME obliga a copiar cada frame por PCIe de NVIDIA a Intel. Con PCIe en Gen 2 y pantalla a 120Hz fijos sin VRR, cualquier variación en el tiempo de entrega de frames produce stutter visible.

**Solución recomendada:** usar `gamescope` como envoltorio para juegos en Steam:

```
# Opciones de lanzamiento en Steam:
gamescope -W 1920 -H 1080 -r 120 -f -- %command%
```

Gamescope puede usar DRM direct scanout desde NVIDIA, saltándose parte del overhead del compositor de Hyprland.

## Probar la config sin reiniciar la sesión

```bash
cd ~/.config/hypr && lua test-config.lua
```

Carga todos los módulos con un `hl` simulado: atrapa errores de sintaxis, `require`
rotos y nils dentro de los callbacks de los binds. **No** valida que los nombres de
opciones existan en Hyprland — para eso, `hyprctl getoption <seccion>:<opcion>` y
`hyprctl configerrors` después de un `hyprctl reload`.

## Nota sobre el BIOS

Ahora mismo **Advanced Optimus está desactivado en BIOS**: la pantalla va directa a la
NVIDIA y todo (compositor incluido) corre por la dGPU. El consumo de ~1 GB de VRAM en
reposo es esperado, no un leak. Toda la sección de PRIME de arriba aplica solo si se
reactiva Optimus.
