# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

This is the **matugen** configuration directory (`~/.config/matugen/`), not a software project. matugen (v4.1.0) extracts a Material You color palette from the wallpaper and renders it into config files for many apps via templates. The desktop is **Hyprland on Wayland (no Plasma)**.

There is no build/lint/test toolchain. "Editing code" here means editing `config.toml` and the `templates/*.tpl` files, then regenerating colors.

## How generation works

`config.toml` is the whole pipeline. Each `[templates.<name>]` block maps one template to one output:
- `input_path` — a `.tpl` template (almost all live in `templates/`; `hyprland` is the exception, its template lives under `~/.config/hypr/scheme/`).
- `output_path` — where the rendered file is written (mostly other apps' config dirs, e.g. `~/.config/kitty/colors.conf`).
- `post_hook` (optional) — command run after writing to make the app reload live (e.g. `pkill -SIGUSR1 kitty`, `hyprctl reload`, `swaync-client --reload-css`).

`reload_apps = true` and `[config.wallpaper]` (uses `awww img ...`) are global. Apps **without** a `post_hook` (qt5ct, qt6ct, kdeglobals, btop, vscode, gtk, tofi) only pick up new colors on restart — there is no live reload for Qt.

Note `templates.qt6ct` and `templates.qt5ct` deliberately share the **same** input template (`qt6ct-colors.conf.tpl`) and write to two different outputs; the `[ColorScheme]` format is identical for both.

## Running / regenerating

matugen is normally invoked outside this dir, from Hyprland:
- Startup: `exec-once = matugen image ~/.config/hypr/wallpaper.jpg` (no `-m` → matugen default mode = **dark**).
- Change wallpaper: `~/.config/hypr/scripts/󰸉 Fondos de Pantalla.sh` runs `matugen image "$PATH" --type scheme-tonal-spot -m "$MODE" --source-color-index 0`.
- Change light/dark: `~/.config/hypr/scripts/󰔎 Modo de Color.sh` — writes `dark`/`light` to `~/.config/hypr/colormode` (the source of `$MODE`), reruns matugen, and sets `gsettings ... color-scheme`.

Regenerate manually after editing a template:
```bash
matugen image ~/.config/hypr/wallpaper.jpg -m "$(cat ~/.config/hypr/colormode)"
```

## Editing templates

Template syntax is matugen's own (Tera-like `{{ ... }}`). The color object is `colors.<role>.<mode>.<format>`:
- `<role>`: Material You roles — `primary`, `on_primary`, `surface`, `surface_container`/`_low`/`_high`/`_highest`/`_lowest`, `on_surface`, `on_surface_variant`, `secondary`, `tertiary`, `error`, `outline`, `outline_variant`, `inverse_surface`, `inverse_on_surface`, etc. Also `base00`..`base0F` (base16) and `source_color`.
- `<mode>`: `default` (follows the `-m` flag passed to matugen), `light`, or `dark`. Use `default` so the output respects the user's chosen mode.
- `<format>`: `hex` (`#rrggbb`), `hex_stripped` (`rrggbb`), `rgb` (`rgb(r, g, b)`), `rgba`, and the per-channel decimals `red` / `green` / `blue` (plain integers — used by `kdeglobals.tpl` because KDE wants `r,g,b`).

There are **no template variables/`set` blocks** — repeat the full `{{ colors... }}` expression at each use site (see `kdeglobals.tpl`, which inlines `red`/`green`/`blue` triples everywhere).

Inspect what a source color produces (handy when authoring a new template):
```bash
matugen color hex "#3584e4" --show-colors          # table of every role, light + dark
```

Test one template in isolation without overwriting real configs — point a throwaway config at `/tmp`:
```bash
printf '[config]\n\n[templates.t]\ninput_path="%s/templates/foo.tpl"\noutput_path="/tmp/foo.out"\n' "$PWD" > /tmp/c.toml
matugen color hex "#3584e4" -m dark -c /tmp/c.toml && cat /tmp/foo.out
```

## Qt / KDE theming (important, non-obvious)

Qt color theming on this system has a known trap documented in `.claude/projects/.../memory/`:
- `qt6ct-colors.conf.tpl` → qt5ct/qt6ct color schemes, and `kdeglobals.tpl` → `~/.config/kdeglobals` are all generated correctly and dark.
- **But** the effective Qt6 dark mode does **not** come from qt6ct. qt6ct reports `colorScheme=Unknown` to Qt6, so the Darkly style renders light. The fix (in `~/.config/hypr/hyprland/env.conf`) is `QT_QPA_PLATFORMTHEME=gtk3` + `QT_STYLE_OVERRIDE=Darkly`, which makes Qt follow the (matugen-themed) GTK theme for the light/dark hint while keeping Darkly.

So changing Qt colors via these templates alone will not change how Qt6 apps look — the GTK templates (`gtk-colors.css.tpl`) are what actually drive Qt6 palettes now. Read the memory files before touching Qt theming.
