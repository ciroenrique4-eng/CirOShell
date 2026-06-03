#!/usr/bin/env bash
HYPR_DIR="$HOME/.config/hypr"

get_icon() {
    case "$1" in
        *animations*)      echo "󰞮" ;;
        *decoration*)      echo "󰏘" ;;
        *env*)             echo "󰙪" ;;
        *execs*)           echo "󰁔" ;;
        *general*)         echo "󰒓" ;;
        *input*)           echo "󰌌" ;;
        *keybinds*)        echo "󰌋" ;;
        *rules*)           echo "󰑓" ;;
        *misc*)            echo "󰏗" ;;
        *group*)           echo "󰕴" ;;
        *gestures*)        echo "󱕸" ;;
        *variables*)       echo "󰫧" ;;
        *scheme*|*colors*) echo "󰏘" ;;
        *hyprland.conf*)   echo "󰣇" ;;
        *)                 echo "󰈚" ;;
    esac
}

# Construir lista con formato "icono|ruta" usando | como separador
LISTA=$(find "$HYPR_DIR" -name "*.conf" | \
    sed "s|$HYPR_DIR/||" | \
    sort | \
    while IFS= read -r file; do
        icon=$(get_icon "$file")
        echo "$icon  $file|$file"
    done)

# Mostrar solo la parte visual en rofi
SELECTED=$(echo "$LISTA" | \
    cut -d'|' -f1 | \
    rofi -dmenu -i -p "󱁻 Config" -theme "$HOME/.config/rofi/menu.rasi")

[[ -z "$SELECTED" ]] && exit 0

# Recuperar la ruta real buscando en la lista original
RUTA=$(echo "$LISTA" | grep -F "$SELECTED" | cut -d'|' -f2 | head -1)

kitty -- micro "$HYPR_DIR/$RUTA"
