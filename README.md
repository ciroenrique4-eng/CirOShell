# Dotfiles

Mis configuraciones para un escritorio basado en **Hyprland**.

## Contenido

| Carpeta   | Aplicación                                   |
|-----------|----------------------------------------------|
| `hypr`    | Hyprland (compositor Wayland, config en Lua) |
| `matugen` | Generación de temas de color (Material You)  |
| `waybar`  | Barra de estado                              |
| `kitty`   | Emulador de terminal                         |
| `micro`   | Editor de texto en terminal                  |
| `rofi`    | Lanzador de aplicaciones / menús             |
| `swaync`  | Centro de notificaciones                     |
| `fish`    | Shell                                        |

## Cómo funciona

Los archivos reales viven en este repositorio. En el sistema, cada carpeta
de `~/.config/<app>` es un **symlink** a su carpeta correspondiente aquí.

Gracias a eso, cualquier cambio que hagas en tus configuraciones (editando en
`~/.config/...` o directamente en `~/dotfiles/...`) queda reflejado
automáticamente en el repositorio, listo para hacer commit.

## Instalación en una máquina nueva

```bash
git clone <url-de-tu-repo> ~/Programacion/CirOShell
cd ~/Programacion/CirOShell
./install.sh
```

El script hace dos cosas:

1. **Instala las dependencias.** Solo los paquetes que falten. Clasifica cada
   uno en tiempo de ejecución: lo que `pacman` conozca va por `pacman`, el
   resto por `paru` o `yay`. Así el mismo script sirve en Arch puro y en
   derivadas como CachyOS, que traen en repo varios paquetes que en Arch son
   de AUR. Si no hay helper de AUR, avisa y sigue con el resto.
2. **Crea los symlinks en `~/.config`.** Si ya existe una configuración previa,
   la respalda con el sufijo `.bak-<fecha>` antes de enlazar (no borra nada).

### Opciones

```bash
./install.sh --dry-run                        # muestra qué haría, sin tocar nada
./install.sh --no-deps                        # solo symlinks, sin instalar paquetes
./install.sh --minimal                        # omite las apps opcionales
./install.sh hypr waybar rofi swaync matugen  # enlaza solo esas apps
```

`--minimal` omite el navegador, el editor, el gestor de archivos y el resto de
apps a las que apuntan los keybinds: el escritorio arranca igual, esos atajos
simplemente no hacen nada.

### Después de instalar

El wallpaper (`hypr/wallpaper.jpg`) es un symlink a una ruta absoluta de la
máquina donde se creó, así que en un equipo nuevo apunta a la nada y el
escritorio arranca sin fondo ni paleta. El instalador avisa si pasa; se arregla
con:

```bash
ln -sf /ruta/a/tu/fondo.jpg ~/.config/hypr/wallpaper.jpg
```

Después, cerrar sesión y volver a entrar para que Hyprland cargue la config.

## Desinstalación

```bash
./uninstall.sh                  # symlinks + respaldos + archivos generados
./uninstall.sh --dry-run        # muestra lo que haría, sin tocar nada
./uninstall.sh --deps           # además desinstala waybar, rofi, swaync, matugen y awww
./uninstall.sh --keep-generated # deja los archivos generados donde están
```

Quita los symlinks que apunten **a este repositorio** (un enlace a otra cosa se
deja tal cual) y restaura el respaldo `.bak-<fecha>` más reciente si lo hay.
También borra lo que Matugen escribió en la config de otras apps, leyendo los
destinos del propio `matugen/config.toml` para no tener la lista duplicada.

No borra el repositorio, no toca `hyprland`/`kitty`/`fish`/`micro` —sirven con
cualquier configuración— y deja en su sitio los archivos que Matugen sobrescribe
enteros pero que seguramente ya existían (`kdeglobals`, la config de VS Code):
los lista al terminar para que decidas.

> Si te quedás sin `~/.config/hypr`, la sesión no arranca. Enlazá otra config
> antes de salir; el script avisa.

## Notas

- **Hyprland usa la sintaxis Lua** (`hypr/hyprland.lua` + `hypr/hyprland/*.lua`),
  no los `.conf` antiguos. Para probar cambios sin reiniciar la sesión:
  `cd ~/.config/hypr && lua test-config.lua`.
- Matugen es el motor de temas: `matugen/config.toml` lista a qué apps les
  regenera el color. Las que no tienen template propio (Feishin, HyprFM, nvim,
  Obsidian, Starship, Steam, Zen) las cubre `~/.local/bin/ciroshell-schemes`,
  que Matugen llama como `post_hook`.
- Pensado para `fish` como shell por defecto.
- El `.gitignore` excluye archivos temporales y de estado (respaldos,
  `fish_variables` temporales, backups de `micro`, etc.).
