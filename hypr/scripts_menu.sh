#!/usr/bin/env bash

# Ruta donde están tus scripts de Hyprland
SCRIPT_DIR="$HOME/.config/hypr/scripts"

# Si Rofi no ha enviado ninguna selección, listamos los archivos
if [ -z "$1" ]; then
    ls -1 "$SCRIPT_DIR"
else
    target="$SCRIPT_DIR/$1"

    # Rofi hace un grab exclusivo del teclado: no pueden coexistir dos
    # instancias. Como muchos de estos scripts abren su propio menú de rofi,
    # desacoplamos la ejecución, esperamos a que el rofi del lanzador se cierre
    # y solo entonces lanzamos el script elegido (que abrirá su propio rofi).
    setsid -f bash -c '
        target=$1
        for _ in $(seq 1 100); do
            pgrep -x rofi >/dev/null || break
            sleep 0.05
        done
        exec "$target"
    ' _ "$target" >/dev/null 2>&1

    # Cerramos el rofi del lanzador para liberar el grab del teclado
    pkill -x rofi
    exit 0
fi
