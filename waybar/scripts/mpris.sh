#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────
# custom/mpris para Waybar
#
# Reemplaza al módulo "mpris" integrado, que tiene un bug de threading en
# libplayerctl/Glib (Glib::DispatchNotifier::send_notification -> SIGSEGV)
# y tumba todo Waybar cuando un navegador actualiza metadata rápido
# (ej: reproducir audio de YouTube).
#
# Aquí playerctl corre en un SUBPROCESO aparte: si llegara a crashear,
# Waybar sigue vivo y solo se reinicia este script (restart-interval).
# ─────────────────────────────────────────────────────────────────────────

# Separador improbable en metadata real (unit separator, 0x1f)
SEP=$'\x1f'

emit_empty() { printf '{"text":"","tooltip":"","class":"stopped"}\n'; }

json_escape() {
  local s=$1
  s=${s//\\/\\\\}
  s=${s//\"/\\\"}
  s=${s//$'\n'/ }
  s=${s//$'\t'/ }
  printf '%s' "$s"
}

# Si no hay playerctl instalado, no rompas la barra
command -v playerctl >/dev/null 2>&1 || { emit_empty; exit 0; }

# --follow emite una línea cada vez que cambia estado/metadata.
# markup_escape protege contra & < > en títulos.
playerctl --follow --format \
  "{{status}}${SEP}{{markup_escape(title)}}${SEP}{{markup_escape(artist)}}" \
  metadata 2>/dev/null |
while IFS= read -r line; do
  status=${line%%"$SEP"*}
  rest=${line#*"$SEP"}
  title=${rest%%"$SEP"*}
  artist=${rest##*"$SEP"}

  # Sin reproductor activo o sin datos -> módulo vacío
  if [[ -z "$status" || ( -z "$title" && -z "$artist" ) ]]; then
    emit_empty
    continue
  fi

  case "$status" in
    Playing) icon="" ;;   #
    Paused)  icon="" ;;   #
    *)       icon="" ;;   #
  esac

  if [[ -n "$artist" ]]; then
    text="$title — $artist"
  else
    text="$title"
  fi

  printf '{"text":"%s %s","tooltip":"%s","class":"%s"}\n' \
    "$icon" "$(json_escape "$text")" \
    "$(json_escape "$text")" \
    "${status,,}"
done

# Si el bucle termina (playerctl murió o se cerró), limpia el módulo.
emit_empty
