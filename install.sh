#!/usr/bin/env bash
#
# install.sh — Crea los symlinks de los dotfiles en ~/.config
#
# Cada carpeta de este repositorio se enlaza a ~/.config/<carpeta>.
# Si ya existe una configuración previa en el destino, se respalda con
# el sufijo .bak-<fecha> antes de crear el enlace (nunca se borra nada).
#
# Uso:
#   ./install.sh            # crea los symlinks
#   ./install.sh --dry-run  # muestra lo que haría sin tocar nada
#
set -euo pipefail

# Directorio donde vive este script (raíz del repo), sin importar desde dónde se ejecute.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Apps a enlazar. Todas van a ~/.config/<app>.
APPS=(hypr matugen waybar kitty micro rofi swaync fish)

DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

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

log "Dotfiles: $DOTFILES_DIR"
log "Destino:  $CONFIG_DIR"
[[ $DRY_RUN -eq 1 ]] && warn "Modo dry-run: no se modificará nada."

run mkdir -p "$CONFIG_DIR"

for app in "${APPS[@]}"; do
  src="$DOTFILES_DIR/$app"
  dst="$CONFIG_DIR/$app"

  if [[ ! -e "$src" ]]; then
    warn "$app: no existe en el repo, lo omito."
    continue
  fi

  # Ya apunta correctamente: nada que hacer.
  if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
    ok "$app ya está enlazado."
    continue
  fi

  # Symlink antiguo (apunta a otro sitio): lo quito sin respaldar.
  if [[ -L "$dst" ]]; then
    warn "$app: enlace antiguo -> $(readlink "$dst"), lo reemplazo."
    run rm "$dst"
  # Archivo o carpeta real existente: lo respaldo.
  elif [[ -e "$dst" ]]; then
    backup="$dst.bak-$(date +%Y%m%d%H%M%S)"
    warn "$app: ya existe configuración, respaldo en $(basename "$backup")"
    run mv "$dst" "$backup"
  fi

  run ln -s "$src" "$dst"
  ok "$app -> $dst"
done

log "Listo."
