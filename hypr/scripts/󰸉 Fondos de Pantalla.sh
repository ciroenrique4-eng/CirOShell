#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/NextCloud/Wallpapers"
WALLPAPER_LINK="$HOME/.config/hypr/wallpaper.jpg"
MODE=$(cat ~/.config/hypr/colormode 2>/dev/null || echo "dark")

# Construir la lista con soporte para miniaturas de Rofi
ROFI_LIST=""
while IFS= read -r file; do
    filename=$(basename "$file")
    ROFI_LIST+="${filename}\0icon\x1f${file}\n"
done < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.webp" \))

# Lanzar Rofi usando tu archivo de configuración específico para wallpapers
SELECTED=$(echo -e "$ROFI_LIST" | rofi -dmenu \
    -config "$HOME/.config/rofi/wallpapers.rasi" \
    -i \
    -p "󰋩 Wallpaper: " \
    -markup-rows)

[[ -z "$SELECTED" ]] && exit 0

FULL_PATH="$WALLPAPER_DIR/$SELECTED"

# 1. Aplicar el wallpaper para Hyprland
ln -sf "$FULL_PATH" "$WALLPAPER_LINK"

# 2. Generar esquema de colores
matugen image "$FULL_PATH" --type scheme-tonal-spot -m "$MODE" --source-color-index 0

# 3. Sobrescribir el fondo de SDDM (necesita permiso de escritura; si no lo hay, se omite)
cp "$FULL_PATH" /usr/share/sddm/themes/pixie/assets/background.jpg 2>/dev/null || true
