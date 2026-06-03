#!/usr/bin/env bash
MODE=$(cat ~/.config/hypr/colormode 2>/dev/null || echo "dark")

SELECTED=$(printf "dark\nlight" | rofi -dmenu -i -p "󰔎 Modo" -theme "$HOME/.config/rofi/menu.rasi")
[[ -z "$SELECTED" ]] && exit 0

echo "$SELECTED" > ~/.config/hypr/colormode
WALLPAPER=$(readlink ~/.config/hypr/wallpaper.jpg)
matugen image "$WALLPAPER" --type scheme-tonal-spot -m "$SELECTED" --source-color-index 0
gsettings set org.gnome.desktop.interface color-scheme \
    $([ "$SELECTED" = "dark" ] && echo "prefer-dark" || echo "prefer-light")
