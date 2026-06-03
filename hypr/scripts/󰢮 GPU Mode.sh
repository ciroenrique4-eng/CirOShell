#!/usr/bin/env bash
# Selector de modo GPU para Hyprland
# Modos disponibles: Integrada, Híbrida, NVIDIA (Reverse PRIME)
#
# card1 = Intel iGPU  (0x8086, eDP-1)
# card2 = NVIDIA dGPU (0x10de)
#
# Requiere cerrar sesión para que el cambio de DRM device surta efecto.

ENV_GPU="$HOME/.config/hypr/hyprland/env_gpu.conf"
STATE_FILE="$HOME/.config/hypr/.gpu-mode"
ROFI_THEME="$HOME/.config/rofi/menu.rasi"

INTEL_CARD="/dev/dri/card1"
NVIDIA_CARD="/dev/dri/card2"

get_mode() { cat "$STATE_FILE" 2>/dev/null || echo "hybrid"; }

write_integrated() {
    cat > "$ENV_GPU" <<EOF
# GPU: Integrada — solo Intel (NVIDIA en standby)
# Generado por ~/.config/hypr/scripts/󰢮 GPU Mode.sh — no editar manualmente
env = WLR_DRM_DEVICES, $INTEL_CARD
env = WLR_NO_HARDWARE_CURSORS, 0
EOF
    echo "integrated" > "$STATE_FILE"
}

write_hybrid() {
    cat > "$ENV_GPU" <<EOF
# GPU: Híbrida — Intel compositor + NVIDIA disponible para offload con prime-run
# Generado por ~/.config/hypr/scripts/󰢮 GPU Mode.sh — no editar manualmente
env = GBM_BACKEND, nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME, nvidia
env = LIBVA_DRIVER_NAME, nvidia
env = NVD_BACKEND, direct
env = __GL_GSYNC_ALLOWED, 1
env = __GL_VRR_ALLOWED, 1
env = WLR_NO_HARDWARE_CURSORS, 1
env = WLR_DRM_DEVICES, $INTEL_CARD
EOF
    echo "hybrid" > "$STATE_FILE"
}

write_nvidia() {
    cat > "$ENV_GPU" <<EOF
# GPU: NVIDIA — compositor en dGPU (Reverse PRIME, mayor consumo)
# Generado por ~/.config/hypr/scripts/󰢮 GPU Mode.sh — no editar manualmente
env = GBM_BACKEND, nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME, nvidia
env = LIBVA_DRIVER_NAME, nvidia
env = NVD_BACKEND, direct
env = __GL_GSYNC_ALLOWED, 1
env = __GL_VRR_ALLOWED, 1
env = WLR_NO_HARDWARE_CURSORS, 1
env = WLR_DRM_DEVICES, $NVIDIA_CARD
EOF
    echo "nvidia" > "$STATE_FILE"
}

# Marcar modo activo con un asterisco
current=$(get_mode)
i_mark=" "; h_mark=" "; n_mark=" "
case "$current" in
    integrated) i_mark="*" ;;
    hybrid)     h_mark="*" ;;
    nvidia)     n_mark="*" ;;
esac

SELECTED=$(printf \
    "${i_mark}󰻠  Integrada   — Solo Intel (máxima batería)\n${h_mark}󰢮  Híbrida     — Intel + NVIDIA bajo demanda\n${n_mark}󰯷  NVIDIA       — Compositor en dGPU (Reverse PRIME)" \
    | rofi -dmenu -i -p "󰢮  GPU Mode" -theme "$ROFI_THEME")

[[ -z "$SELECTED" ]] && exit 0

case "$SELECTED" in
    *Integrada*)  write_integrated; label="Integrada (Solo Intel)" ;;
    *Híbrida*)    write_hybrid;     label="Híbrida (Optimus)" ;;
    *NVIDIA*)     write_nvidia;     label="NVIDIA Reverse PRIME" ;;
    *) exit 0 ;;
esac

# Si supergfxctl está disponible, usarlo también para gestión de energía
if command -v supergfxctl >/dev/null 2>&1; then
    case "$label" in
        *Intel*)  supergfxctl -m Integrated 2>/dev/null ;;
        *Híbrida*) supergfxctl -m Hybrid    2>/dev/null ;;
        *NVIDIA*) supergfxctl -m Dedicated  2>/dev/null ;;
    esac
fi

# Preguntar si cerrar sesión ahora o guardar para la próxima
CONFIRM=$(printf \
    "Cerrar sesión ahora\nAplicar en la próxima sesión" \
    | rofi -dmenu -i -p "Modo guardado: $label" -theme "$ROFI_THEME")

case "$CONFIRM" in
    "Cerrar sesión ahora")
        notify-send "GPU Mode" "Cambiando a: $label\nCerrando sesión..." -t 3000
        sleep 2
        hyprctl dispatch exit
        ;;
    *)
        notify-send "GPU Mode" "Guardado: $label\nAplicará en la próxima sesión." -t 4000
        ;;
esac
