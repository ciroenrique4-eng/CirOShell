#!/usr/bin/env bash
HYPR_DIR="$HOME/.config/waybar"

get_icon() {
    case "$1" in
        *config*|*.jsonc*) echo "󰒓" ;;
        *style*|*colors*|*.css*) echo "󰏘" ;;
        *) echo "󰈚" ;;
    esac
}

# Construir lista con formato "icono|ruta" usando | como separador
LISTA=$(find "$HYPR_DIR" -name "*.jsonc" -o -name "*.css" | \
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
