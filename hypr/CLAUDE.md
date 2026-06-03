# Hyprland Config — Contexto del sistema

## Hardware

- **CPU:** Intel Core i5-13450HX (Raptor Lake-S, 13ª gen)
- **iGPU:** Intel UHD Graphics (i915) — driver: `iris`
- **dGPU:** NVIDIA GeForce RTX 4050 Laptop GPU — driver: `nvidia 610.43.02`
- **RAM:** 16 GB
- **Pantalla:** eDP-1, 1920×1080 @ 120Hz fijos (sin VRR/Adaptive Sync hardware)
- **Kernel:** CachyOS (linux-cachyos)
- **Compositor:** Hyprland 0.55.2 en Wayland (con Xwayland)

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

### env.conf — GPU/NVIDIA

La sección GPU se gestiona dinámicamente mediante `env_gpu.conf` (no editar a mano):

```ini
# En env.conf:
source = ~/.config/hypr/hyprland/env_gpu.conf
```

El archivo `env_gpu.conf` lo escribe el script `scripts/󰢮 GPU Mode.sh`. Ejemplo del modo híbrido:

```ini
env = GBM_BACKEND, nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME, nvidia
env = LIBVA_DRIVER_NAME, nvidia
env = NVD_BACKEND, direct          # mejor decodificación HW con ffmpeg/mpv
env = __GL_GSYNC_ALLOWED, 1
env = __GL_VRR_ALLOWED, 1
env = WLR_NO_HARDWARE_CURSORS, 1   # evita bugs de cursor con NVIDIA en Wayland
env = WLR_DRM_DEVICES, /dev/dri/card1   # card1=Intel, card2=NVIDIA
```

> `__GL_GSYNC_ALLOWED` y `__GL_VRR_ALLOWED` aplican principalmente a X11/GLX, no a Wayland nativo. En Wayland el VRR lo controla `vrr` en misc.conf.

### hyprland.conf — nivel raíz

```ini
explicit_sync  = 2      # necesario para NVIDIA en Wayland
unscale_layers = true
```

### misc.conf

```ini
vrr = 2   # 0=off, 1=siempre, 2=solo fullscreen
```

La pantalla no tiene VRR hardware → Hyprland lo detecta y cae a 120Hz fijos. El valor `2` no hace daño.

### rules.conf — juegos

```ini
windowrule = opaque true,        match:class (steam_app_(default|[0-9]+))|gamescope
windowrule = immediate true,     match:class (steam_app_(default|[0-9]+))|gamescope
windowrule = idle_inhibit always, match:class (steam_app_(default|[0-9]+))|gamescope
```

`immediate = true` permite tearing (frames sin esperar vblank). Requiere `allow_tearing = true` en `general.conf`, que ya está activo.

## Problema de stutter en juegos

**Síntoma:** el juego rinde bien en FPS pero la pantalla se ve trabada/stuttering.

**Causa raíz:** la arquitectura PRIME obliga a copiar cada frame por PCIe de NVIDIA a Intel. Con PCIe en Gen 2 y pantalla a 120Hz fijos sin VRR, cualquier variación en el tiempo de entrega de frames produce stutter visible.

**Solución recomendada:** usar `gamescope` como envoltorio para juegos en Steam:

```
# Opciones de lanzamiento en Steam:
gamescope -W 1920 -H 1080 -r 120 -f -- %command%
```

Gamescope puede usar DRM direct scanout desde NVIDIA, saltándose parte del overhead del compositor de Hyprland.

## Cambios aplicados en esta sesión

| Archivo | Cambio |
|---|---|
| `hyprland/misc.conf` | `vrr = 0` → `vrr = 2` |
| `hyprland/env.conf` | `__GL_*_ALLOWED` de 0 a 1, añadido `WLR_NO_HARDWARE_CURSORS=1` |
| `/etc/udev/rules.d/99-nvidia-pcie.rules` | Mantener NVIDIA en PCIe active (Gen 4) |
