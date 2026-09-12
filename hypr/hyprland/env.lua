local vars = require("variables")

-- === Temas Qt ===
-- gtk3 reporta colorScheme=Dark (qt6ct siempre da Unknown y Darkly se pinta claro).
-- QT_STYLE_OVERRIDE fuerza Darkly; la paleta oscura viene del tema GTK (matugen).
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_STYLE_OVERRIDE", "Darkly")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("XCURSOR_THEME", vars.cursorTheme)
hl.env("XCURSOR_SIZE", vars.cursorSize)

-- === Backends de toolkit ===
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland,x11,windows")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- === XDG ===
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- === Otros ===
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

-- === GPU (lo genera scripts/󰢮 GPU Mode.sh) ===
-- pcall: si el archivo todavía no existe, la sesión arranca igual con el default del driver.
pcall(require, "hyprland.env_gpu")
