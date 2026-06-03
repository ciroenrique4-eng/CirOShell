# Dotfiles

Mis configuraciones para un escritorio basado en **Hyprland**.

## Contenido

| Carpeta   | Aplicación                                   |
|-----------|----------------------------------------------|
| `hypr`    | Hyprland (compositor Wayland)                |
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
git clone <url-de-tu-repo> ~/dotfiles
cd ~/dotfiles
./install.sh
```

El script crea los symlinks en `~/.config`. Si ya existe una configuración
previa, la respalda con el sufijo `.bak-<fecha>` antes de enlazar (no borra
nada). Para ver qué haría sin aplicar cambios:

```bash
./install.sh --dry-run
```

## Notas

- Pensado para `fish` como shell por defecto.
- El `.gitignore` excluye archivos temporales y de estado (respaldos,
  `fish_variables` temporales, backups de `micro`, etc.).
