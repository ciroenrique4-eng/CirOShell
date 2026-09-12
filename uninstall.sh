#!/usr/bin/env bash
#
# uninstall.sh — deshace lo que hizo install.sh.
#
# Quita los symlinks de ~/.config que apuntan a este repositorio y restaura el
# respaldo .bak-<fecha> más reciente si install.sh había guardado uno. También
# borra los archivos que Matugen genera en otras apps, porque quedarían como
# basura con colores de un escritorio que ya no está.
#
# Lo que NO hace, a propósito:
#   · No borra este repositorio.
#   · No toca archivos que ya existían antes (kdeglobals, la config de VS Code):
#     Matugen los sobrescribe enteros, así que no hay forma de saber qué había.
#     Se listan al final para que decidas.
#   · No desinstala paquetes salvo que se pida con --deps.
#
# Uso:
#   ./uninstall.sh                  # symlinks + respaldos + archivos generados
#   ./uninstall.sh --dry-run        # muestra lo que haría sin tocar nada
#   ./uninstall.sh --deps           # además desinstala los paquetes de esta shell
#   ./uninstall.sh --keep-generated # deja los archivos generados donde están
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"
BIN_DIR="$HOME/.local/bin"

APPS=(hypr matugen waybar kitty micro rofi swaync fish)

# Paquetes que solo sirven a estos dotfiles. Deliberadamente NO están aquí
# hyprland, kitty, fish ni micro: son el compositor y herramientas que se
# siguen usando con cualquier otra configuración.
PKGS_SHELL=(waybar rofi swaync matugen awww)

# Generados por Matugen pero que casi seguro ya existían antes con contenido
# propio. Se informan en vez de borrarse.
NO_BORRAR=(
  "$CONFIG_DIR/kdeglobals"
  "$CONFIG_DIR/Code/User/settings.json"
)

DRY_RUN=0
DEPS=0
KEEP_GENERATED=0

while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --dry-run)        DRY_RUN=1 ;;
    --deps)           DEPS=1 ;;
    --keep-generated) KEEP_GENERATED=1 ;;
    *) echo "Opción desconocida: $1" >&2; exit 1 ;;
  esac
  shift
done

log()  { printf '\033[1;34m::\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m %s\n' "$*"; }
ok()   { printf '\033[1;32mok\033[0m %s\n' "$*"; }

run() {
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "   [dry-run] $*"
  else
    "$@"
  fi
}

en_no_borrar() {
  local f
  for f in "${NO_BORRAR[@]}"; do
    [[ "$1" == "$f" ]] && return 0
  done
  return 1
}


############################
####  Symlinks y backups ###
############################

quitar_symlinks() {
  local restaurados=0 quitados=0

  for app in "${APPS[@]}"; do
    local dst="$CONFIG_DIR/$app"

    # Solo se toca si apunta a ESTE repo: un symlink a otra cosa es de otra
    # configuración y no nos corresponde.
    if [[ -L "$dst" && "$(readlink "$dst")" == "$DOTFILES_DIR/$app" ]]; then
      run rm "$dst"
      quitados=$((quitados + 1))
      ok "$app: enlace quitado."
    elif [[ -L "$dst" ]]; then
      warn "$app: enlazado a $(readlink "$dst"), no es de este repo — lo dejo."
      continue
    elif [[ -e "$dst" ]]; then
      warn "$app: hay una config real (no un enlace) — la dejo."
      continue
    fi

    # Restaurar el respaldo más reciente que dejó install.sh.
    local backup
    backup="$(find "$CONFIG_DIR" -maxdepth 1 -name "$app.bak-*" 2>/dev/null | sort | tail -1)"
    if [[ -n "$backup" ]]; then
      run mv "$backup" "$dst"
      restaurados=$((restaurados + 1))
      ok "$app: restaurado desde $(basename "$backup")"
    fi
  done

  log "$quitados enlaces quitados, $restaurados configuraciones restauradas."
}


##############################
####  Archivos generados  ####
##############################

# La lista de destinos sale del propio matugen/config.toml en vez de estar
# duplicada aquí: si se añade un template nuevo, el desinstalador lo cubre solo.
borrar_generados() {
  local toml="$DOTFILES_DIR/matugen/config.toml"
  local pendientes=()

  if [[ -f "$toml" ]]; then
    while IFS= read -r destino; do
      destino="${destino/#\~/$HOME}"
      [[ -e "$destino" ]] || continue

      # Lo que vive dentro del repo desaparece con el repo; aquí solo interesa
      # lo que Matugen escribió en la config de otras apps. Hay que resolver el
      # enlace: ~/.config/waybar/colors.css *es* un archivo del repo mientras el
      # symlink siga puesto, y borrarlo sería borrar contenido versionado.
      local real
      real="$(readlink -f "$destino")"
      [[ "$real" == "$DOTFILES_DIR"* ]] && continue

      if en_no_borrar "$destino"; then
        pendientes+=("$destino")
        continue
      fi

      run rm -f "$destino"
      ok "generado: $(basename "$destino") ($(dirname "${destino/#$HOME/\~}"))"
    done < <(grep -oP 'output_path\s*=\s*"\K[^"]+' "$toml")
  fi

  # kitty lee la paleta por un `include` que añade la instalación al kitty.conf
  # del usuario. Sin colors.conf, kitty arranca con un error en cada ventana.
  local kittyconf="$CONFIG_DIR/kitty/kitty.conf"
  if [[ -f "$kittyconf" ]] && grep -q '^include colors.conf' "$kittyconf"; then
    if [[ $DRY_RUN -eq 1 ]]; then
      echo "   [dry-run] quitar el 'include colors.conf' de kitty.conf"
    else
      # Quita la línea y el bloque de comentario que la introduce.
      sed -i '/^# --- Paleta dinámica (matugen) ---$/,/^include colors\.conf$/d' "$kittyconf"
      sed -i '/^include colors\.conf$/d' "$kittyconf"
    fi
    ok "kitty.conf: include de la paleta quitado."
  fi

  # Estado y ayudante propios.
  [[ -d "$STATE_DIR/ciroshell" ]] && { run rm -rf "$STATE_DIR/ciroshell"; ok "estado: ~/.local/state/ciroshell"; }
  [[ -f "$BIN_DIR/ciroshell-schemes" ]] && { run rm -f "$BIN_DIR/ciroshell-schemes"; ok "ayudante: ~/.local/bin/ciroshell-schemes"; }

  if [[ ${#pendientes[@]} -gt 0 ]]; then
    echo
    warn "Estos los genera Matugen pero seguramente ya existían con contenido tuyo."
    warn "Los dejo; revisalos y borralos a mano si no los querés:"
    for f in "${pendientes[@]}"; do
      printf '     %s\n' "${f/#$HOME/\~}"
    done
  fi
}


######################
####  Paquetes    ####
######################

quitar_paquetes() {
  if ! command -v pacman >/dev/null; then
    warn "pacman no disponible: desinstalá a mano ${PKGS_SHELL[*]}"
    return 0
  fi

  local instalados=()
  for p in "${PKGS_SHELL[@]}"; do
    pacman -Qq "$p" &>/dev/null && instalados+=("$p")
  done

  if [[ ${#instalados[@]} -eq 0 ]]; then
    ok "Ninguno de los paquetes de la shell está instalado."
    return 0
  fi

  log "Desinstalando (${#instalados[@]}): ${instalados[*]}"
  warn "No se tocan hyprland, kitty, fish ni micro: sirven con cualquier config."
  # Sin --noconfirm: que pacman muestre las dependencias que se lleva y pregunte.
  run sudo pacman -Rns "${instalados[@]}"
}


#################
####  Main   ####
#################

log "Dotfiles: $DOTFILES_DIR"
log "Destino:  $CONFIG_DIR"
[[ $DRY_RUN -eq 1 ]] && warn "Modo dry-run: no se modificará nada."

quitar_symlinks

if [[ $KEEP_GENERATED -eq 1 ]]; then
  log "Dejando los archivos generados (--keep-generated)."
else
  borrar_generados
fi

[[ $DEPS -eq 1 ]] && quitar_paquetes

echo
log "Listo. El repositorio sigue en $DOTFILES_DIR (bórralo a mano si querés)."
if [[ -L "$CONFIG_DIR/hypr" || ! -e "$CONFIG_DIR/hypr" ]]; then
  warn "Sin config de Hyprland la sesión no arranca: enlazá otra antes de salir."
  warn "  ln -sfn /ruta/a/tu/config ~/.config/hypr && hyprctl reload"
fi
