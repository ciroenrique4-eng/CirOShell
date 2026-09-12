# Notas para trabajar en esta config de Waybar

## ⚠️ Glifos de iconos: se pierden en silencio al editar

Los glifos del **Private Use Area del BMP** (`U+E000–U+F8FF`: Devicons, Font Awesome,
Octicons, Seti — el icono de terminal, el de Chrome, el punto de workspace vacío…)
**se pierden con facilidad** al escribir el archivo con herramientas que no preservan
ese rango: la cadena queda vacía. No hay ningún error: el icono simplemente no se
dibuja y el botón se ve vacío.

Los **Material Design** (`U+F0000` en adelante: 󰤨 red, 󰁹 batería, 󰐥 apagar) quedan
fuera del BMP y **sí** sobreviven la edición normal.

### Comprobarlo siempre

```bash
./test-icons.py
```

Recorre `format`, `format-icons` y `window-rewrite` de `config.jsonc` y falla si un
icono quedó vacío o si el glifo no existe en la fuente de `style.css`. El único
vacío intencional está listado en `VACIOS_INTENCIONALES` dentro del script: en
workspaces, `{icon}` se anula en `default` para dejar sitio a `{windows}`.

Para ver los codepoints que hay ahora mismo en un archivo:

```bash
python3 -c "import sys; print(' '.join(f'U+{ord(c):05X}' for c in open(sys.argv[1]).read() if ord(c)>0x2000))" config.jsonc
```

### Editar un icono sin perderlo

Escribirlo por codepoint, nunca pegando el carácter:

```python
p = pathlib.Path("config.jsonc"); s = p.read_text()
s = s.replace('"class<kitty>": "X"', '"class<kitty>": "%s"' % chr(0xE795))
p.write_text(s)
```

Lo mismo vale para los patrones de búsqueda: un `replace()` cuyo texto a buscar
lleve un glifo pegado no encuentra nada y el cambio se pierde sin avisar. Buscar
por la parte ASCII de la línea, o con `re.sub` y `"[^"]*"` para saltarse el glifo.

### Buscar el codepoint de un glifo por nombre

No fiarse de listas web, que van desfasadas respecto a la fuente instalada:

```python
from fontTools.ttLib import TTFont
f = TTFont("/usr/share/fonts/TTF/FiraCodeNerdFont-Regular.ttf", lazy=True)
cm = {}
for t in f["cmap"].tables: cm.update(t.cmap)
rev = {}
for cp, n in cm.items(): rev.setdefault(n, cp)
print(hex(rev["dev-terminal"]))   # 0xe795
```

## Diseño: taskbar, no isla flotante

`height: 40`, sin `margin-*` ni `border-radius` en `window#waybar`: la barra es una
franja pegada al borde inferior, a ancho completo.

La regla del CSS es **casi todo plano**. El color se reserva para lo que hay que
mirar: el workspace activo, el reloj y los estados de alerta. Si todos los módulos
llevan fondo, ninguno destaca.

- **Izquierda:** logo de la distro y workspaces. El logo es el lanzador
  (`rofi -show drun`) y lleva el menú de scripts en **clic derecho**; no hay un
  segundo botón, sería el mismo lanzador dos veces.

  Los workspaces usan `format: "{icon}{windows}"` — los ocupados muestran los iconos
  de sus apps (vía `window-rewrite`), los vacíos un punto. El activo es el único con
  fondo.

  **`format-icons` no define `active` ni `urgent` a propósito.** waybar los consulta
  *antes* que `empty`, así que con un `"active": ""` (vacío, para dejar sitio a
  `{windows}`) un workspace activo y sin ventanas se quedaba en blanco. Sin esas
  claves, el activo con ventanas cae en `default` y el activo vacío en `empty`; el
  estado ya se distingue por el fondo que le da el CSS.
- **Centro:** `hyprland/window` con `{initialTitle}` (el nombre de la app, "Zen
  Browser") en vez de `{title}`, que cambia con cada pestaña y hace bailar la barra.
  El `rewrite` resuelve los dos casos: `"^$"` para cuando no hay nada enfocado
  (queda "Desktop :3") y `"^(.+)$"` para anteponer el icono de ventana al resto.
  Sin la primera regla el módulo dejaba el icono suelto, sin texto.
- **Derecha:** reproductor, inhibidor, notificaciones, reloj (el único pill fijo),
  teclado, bluetooth, red, perfil de energía, batería, apagar.

## Notificaciones y direct scanout

El módulo `custom/notifications` lleva **clic derecho = No molestar**, y eso importa
para jugar: mientras hay una notificación en pantalla, su capa se dibuja encima de la
ventana fullscreen y Hyprland pierde el direct scanout. Medido:

| Estado | `directScanoutBlockedBy` |
|---|---|
| Fullscreen limpio | `null` |
| Con notificación visible | `missing candidate` |
| Tras expirar (6 s) | `null` |
| **Con No molestar activado** | **`null`** |

Se recupera solo, pero las críticas no expiran (`timeout-critical: 0`), así que una
notificación crítica deja el scanout bloqueado hasta cerrarla. Para jugar, DND.

## Reproductor: `custom/mpris` en vez del módulo `mpris` integrado

El módulo `mpris` integrado de Waybar **crashea toda la barra** (SIGSEGV en
`libplayerctl` → `Glib::DispatchNotifier::send_notification`) cuando un navegador
actualiza metadata rápido (p. ej. audio de YouTube en Firefox/Chrome).

Por eso se usa `scripts/mpris.sh`, que ejecuta `playerctl --follow` en un
**subproceso aislado**: si playerctl falla, Waybar sobrevive y el script se reinicia
solo (`restart-interval` en `config.jsonc`). **No volver al módulo `mpris` integrado.**

## Otros datos

- `colors.css` lo **genera matugen** — no editar a mano. `style.css` sí es nuestro.
- Recargar en caliente tras cambios de CSS: `killall -SIGUSR2 waybar`.
  Tras cambios en `config.jsonc` hay que reiniciar la barra entera.
- Un par de `[waybar] <defunct>` en `ps` es normal tras reiniciar la barra: son
  restos de los `on-click`, no crecen. Si el número sube solo, ahí sí hay una fuga
  en algún módulo custom.
- Pantalla: eDP-1, 1920px, scale 1.0.
