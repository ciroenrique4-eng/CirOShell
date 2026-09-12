local vars = require("variables")

local hypr      = (os.getenv("HOME")) .. "/.config/hypr"
local wallpaper = hypr .. "/wallpaper.jpg"

hl.on("hyprland.start", function()
    -- === Autenticación y keyring ===
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- === Portales XDG (screensharing, filepickers, etc.) ===
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal")

    -- === Portapapeles ===
    hl.exec_cmd("wl-paste --type text  --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- === Cursor ===
    hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme '" .. vars.cursorTheme .. "'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. vars.cursorSize)

    -- === Luz de noche ===
    hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
    hl.exec_cmd("sleep 1 && gammastep")

    -- === MPRIS (controles bluetooth de media) ===
    hl.exec_cmd("mpris-proxy")

    -- === Wallpaper (Matugen llama a awww para regenerar los colores) ===
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("awww img " .. wallpaper)

    -- === Barra y notificaciones ===
    hl.exec_cmd("waybar")
    hl.exec_cmd("swaync")

    -- === Limpieza de basura ===
    hl.exec_cmd("trash-empty 30")

    -- === Matugen: regenerar la paleta al iniciar ===
    -- --source-color-index no es opcional: sin él, un wallpaper con varios colores
    -- candidatos hace que matugen pida elegir por terminal, y en el arranque no hay
    -- ninguna → falla en silencio y la sesión se queda con la paleta vieja.
    -- El modo sale de `colormode`, que escribe scripts/󰔎 Modo de Color.sh.
    hl.exec_cmd(
        "matugen image " .. wallpaper ..
        " --type scheme-tonal-spot --source-color-index 0" ..
        " -m \"$(cat " .. hypr .. "/colormode 2>/dev/null || echo dark)\""
    )
end)
