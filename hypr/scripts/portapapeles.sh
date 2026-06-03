#!/usr/bin/env bash

cache_dir="/tmp/rofi-cliphist"
mkdir -p "$cache_dir"

selected=$(cliphist list | while read -r line; do
    id=$(echo "$line" | cut -f 1)
    
    if [[ "$line" == *"[[ binary data"* ]]; then
        img_path="$cache_dir/$id.jpg"
        
        if [ ! -f "$img_path" ]; then
            echo "$line" | cliphist decode > "$img_path"
        fi
        
        # Inyecta la previsualización de la imagen
        echo -en "${line}\0icon\x1f${img_path}\n"
    else
        # INYECCIÓN PARA TEXTO: Usamos el icono 'edit-copy' de tu tema Papiru
        echo -en "${line}\0icon\x1fedit-copy\n"
    fi
done | rofi -dmenu -theme ~/.config/rofi/papeles.rasi)

if [ -z "$selected" ]; then
    exit 0
fi

echo "$selected" | cliphist decode | wl-copy
