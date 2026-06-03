#!/usr/bin/env bash
SCRIPTS_DIR="$HOME/.config/hypr/scripts/bluetooth"

SELECTED=$(find "$SCRIPTS_DIR" -maxdepth 1 -name "*.sh" ! -name "scripts.sh" | \
    sed "s|$SCRIPTS_DIR/||; s|\.sh||" | \
    rofi -dmenu -i -p "󰂯 Bluetooth" -theme "$HOME/.config/rofi/menu.rasi")

[[ -z "$SELECTED" ]] && exit 0

bash "$SCRIPTS_DIR/$SELECTED.sh"
