# Notas para trabajar en esta config de Waybar

## ⚠️ Glifos de iconos: editar por codepoint, NO pegando el carácter

Los glifos **Font Awesome de 3 bytes** (rango BMP-PUA, `U+E000–U+F8FF`: workspaces ○◉●,
reloj , calendario , play/pause ▶⏸, balanza , etc.) **se pierden** al
escribir los archivos con las herramientas de edición de texto: quedan como `""` vacío.
Un botón de workspace sin icono se ve como un **cuadro vacío**.

Los glifos **Material Design de 4 bytes** (rango `U+F0000+`, los que genera matugen,
ej. batería 󰁹, red 󰤨, CPU 󰍛) **sí** sobreviven la edición normal.

### Cómo editar/reponer un glifo de 3 bytes correctamente
Hacerlo por **codepoint explícito** vía Python (a prueba del problema):

```bash
cd ~/.config/waybar
python3 - <<'EOF'
import re
s=open('config.jsonc',encoding='utf-8').read()
s=re.sub(r'"focused":\s*""', '"focused": ""', s)   # ejemplo
open('config.jsonc','w',encoding='utf-8').write(s)
EOF
```

### Codepoints en uso (verificados presentes en FiraCode Nerd Font v6)
| Elemento | Glifo | Codepoint |
|----------|-------|-----------|
| Workspace sin foco / vacío | ○ | `U+F1DB` |
| Workspace con foco | ◉ | `U+F192` |
| Workspace activo | ● | `U+F111` |
| Perfil balanceado | balanza | `U+F24E` |
| Reloj | reloj | `U+F017` |
| Fecha (`format-alt`) | calendario | `U+F073` |
| Reproductor: Playing / Paused / default | ▶ / ⏸ / ♪ | `U+F04B` / `U+F04C` / `U+F001` |

Para comprobar qué codepoints tiene un archivo:
```bash
python3 -c "import sys; print(' '.join(f'U+{ord(c):04X}' for c in open(sys.argv[1]).read()))" archivo
```

## Reproductor: `custom/mpris` en vez del módulo `mpris` integrado

El módulo `mpris` integrado de Waybar **crashea toda la barra** (SIGSEGV en
`libplayerctl` → `Glib::DispatchNotifier::send_notification`) cuando un navegador
actualiza metadata rápido (p. ej. reproducir audio de YouTube en Firefox/Chrome).

Por eso se usa `scripts/mpris.sh`, que ejecuta `playerctl --follow` en un
**subproceso aislado**: si playerctl falla, Waybar sobrevive y el script se reinicia
solo (`restart-interval` en `config.jsonc`). **No volver al módulo `mpris` integrado.**

## Otros datos
- `colors.css` lo **genera matugen** — no editar a mano.
- Recargar en caliente tras cambios: `killall -SIGUSR2 waybar`.
- Respaldos previos al rediseño minimalista: `config.jsonc.bak`, `style.css.bak`.
- Pantalla: eDP-1, 1920px, scale 1.0. Márgenes laterales (`margin-left/right`)
  controlan el ancho de la barra; mayor valor = más angosta.
