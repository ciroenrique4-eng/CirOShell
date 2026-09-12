#!/usr/bin/env bash
#
# install.sh — Instala las dependencias y crea los symlinks de los dotfiles.
#
# Cada carpeta de este repositorio se enlaza a ~/.config/<carpeta>.
# Si ya existe una configuración previa en el destino, se respalda con
# el sufijo .bak-<fecha> antes de crear el enlace (nunca se borra nada).
#
# Uso:
#   ./install.sh                        # dependencias + todas las apps
#   ./install.sh hypr waybar rofi       # dependencias + solo esas apps
#   ./install.sh --dry-run [apps...]    # muestra lo que haría sin tocar nada
#   ./install.sh --no-deps              # solo symlinks, sin instalar paquetes
#   ./install.sh --minimal              # omite las apps opcionales (navegador, editor…)
#
set -euo pipefail

# Directorio donde vive este script (raíz del repo), sin importar desde dónde se ejecute.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# Apps a enlazar. Todas van a ~/.config/<app>.
APPS=(hypr matugen waybar kitty micro rofi swaync fish)

# Paquetes que la configuración invoca directamente: sin ellos el escritorio
# arranca roto (barra, launcher, notificaciones, wallpaper, atajos de sistema).
PKGS=(
  hyprland waybar rofi swaync matugen awww kitty fish micro
  hyprlock hyprpicker grimblast-git gammastep geoclue
  polkit-gnome gnome-keyring cliphist wl-clipboard
  playerctl brightnessctl wireplumber trash-cli
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
  bluez-utils libnotify glib2 dbus lua
  ttf-jetbrains-mono-nerd papirus-icon-theme bibata-cursor-theme-bin
)

# Apps a las que apuntan keybinds y reglas de ventana. El escritorio funciona
# sin ellas: el atajo simplemente no hace nada. Se omiten con --minimal.
PKGS_EXTRA=(
  neovim btop yazi hyprfm-git zen-browser-bin feishin github-desktop
)

DRY_RUN=0
NO_DEPS=0
MINIMAL=0

while [[ "${1:-}" == --* ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --no-deps) NO_DEPS=1 ;;
    --minimal) MINIMAL=1 ;;
    *) echo "Opción desconocida: $1" >&2; exit 1 ;;
  esac
  shift
done

# Apps pasadas por argumento: enlazar solo esas.
[[ $# -gt 0 ]] && APPS=("$@")

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


########################
####  Dependencias  ####
########################

instalar_dependencias() {
  local pendientes=() repo=() aur=() helper=""

  [[ $MINIMAL -eq 0 ]] && PKGS+=("${PKGS_EXTRA[@]}")

  if ! command -v pacman >/dev/null; then
    warn "pacman no está disponible: esto no parece Arch ni una derivada."
    warn "Instalá a mano el equivalente de: ${PKGS[*]}"
    return 0
  fi

  # Solo lo que falte, para no reinstalar media distro en cada ejecución.
  for p in "${PKGS[@]}"; do
    pacman -Qq "$p" &>/dev/null || pendientes+=("$p")
  done

  if [[ ${#pendientes[@]} -eq 0 ]]; then
    ok "Todas las dependencias ya están instaladas."
    return 0
  fi

  # Se clasifica en tiempo de ejecución en vez de mantener dos listas a mano:
  # qué paquete vive en los repos y cuál en AUR cambia según la distro
  # (CachyOS trae en repo varios que en Arch puro son de AUR).
  for p in "${pendientes[@]}"; do
    if pacman -Si "$p" &>/dev/null; then repo+=("$p"); else aur+=("$p"); fi
  done

  if [[ ${#repo[@]} -gt 0 ]]; then
    log "Paquetes de los repos (${#repo[@]}): ${repo[*]}"
    run sudo pacman -S --needed "${repo[@]}"
  fi

  if [[ ${#aur[@]} -gt 0 ]]; then
    for h in paru yay; do
      command -v "$h" >/dev/null && { helper="$h"; break; }
    done

    if [[ -z "$helper" ]]; then
      warn "Paquetes de AUR pendientes y no hay paru ni yay: ${aur[*]}"
      warn "Instalá un helper de AUR y volvé a ejecutar, o instalalos a mano."
    else
      log "Paquetes de AUR (${#aur[@]}, vía $helper): ${aur[*]}"
      run "$helper" -S --needed "${aur[@]}"
    fi
  fi
}


####################
####  Symlinks  ####
####################

enlazar_apps() {
  run mkdir -p "$CONFIG_DIR"

  for app in "${APPS[@]}"; do
    local src="$DOTFILES_DIR/$app"
    local dst="$CONFIG_DIR/$app"

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
      local backup="$dst.bak-$(date +%Y%m%d%H%M%S)"
      warn "$app: ya existe configuración, respaldo en $(basename "$backup")"
      run mv "$dst" "$backup"
    fi

    run ln -s "$src" "$dst"
    ok "$app -> $dst"
  done
}


#################
####  Main   ####
#################

log "Dotfiles: $DOTFILES_DIR"
log "Destino:  $CONFIG_DIR"
[[ $DRY_RUN -eq 1 ]] && warn "Modo dry-run: no se modificará nada."

if [[ $NO_DEPS -eq 1 ]]; then
  log "Omitiendo dependencias (--no-deps)."
else
  instalar_dependencias
fi

enlazar_apps

# El wallpaper es un symlink dentro del repo y apunta a una ruta absoluta que solo
# existe en la máquina donde se creó. Si está roto, la sesión arranca sin fondo y
# sin paleta: es la causa nº1 de "lo instalé y se ve todo gris".
if [[ ! -e "$DOTFILES_DIR/hypr/wallpaper.jpg" ]]; then
  warn "hypr/wallpaper.jpg apunta a un archivo que no existe en este equipo."
  warn "Arreglalo con:  ln -sf /ruta/a/tu/fondo.jpg $DOTFILES_DIR/hypr/wallpaper.jpg"
fi

log "Listo. Cerrá sesión y volvé a entrar para arrancar Hyprland con esta config."
