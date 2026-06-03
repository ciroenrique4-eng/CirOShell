#!/usr/bin/env bash
MATUGEN_DIR="$HOME/.config/matugen"

get_icon() {
    case "$1" in
        *config*|*.toml*) echo "󰒓" ;;
        *kitty*)          echo "" ;;
        *waybar*)         echo "󰈿" ;;
        *swaync*)         echo "󰂚" ;;
        *rofi*)           echo "󰍉" ;;
        *gtk*)            echo "󰖲" ;;
        *btop*)           echo "󰍛" ;;
        *hyprland*)       echo "󰣇" ;;
        *.css*|*.tpl*)    echo "󰏘" ;;
        *)                echo "󰈚" ;;
    esac
}

LISTA=$(find "$MATUGEN_DIR" -type f \( -name "*.toml" -o -name "*.tpl" -o -name "*.css" -o -name "*.conf" \) | \
    sed "s|$MATUGEN_DIR/||" | \
    sort | \
    while IFS= read -r file; do
        icon=$(get_icon "$file")
        echo "$icon  $file|$file"
    done)

SELECTED=$(echo "$LISTA" | \
    cut -d'|' -f1 | \
    rofi -dmenu -i -p "󰔌 Matugen" -theme "$HOME/.config/rofi/menu.rasi")

[[ -z "$SELECTED" ]] && exit 0

RUTA=$(echo "$LISTA" | grep -F "$SELECTED" | cut -d'|' -f2 | head -1)
kitty -- micro "$MATUGEN_DIR/$RUTA"
