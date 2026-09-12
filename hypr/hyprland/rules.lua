local vars = require("variables")

-- Etiqueta un array de matches. Con `field`, los matches son strings; sin él, tablas.
local function tagged_rule(tag, matches, field)
    for _, match in ipairs(matches) do
        if field then
            local t = {}
            t[field] = match
            match = t
        end
        hl.window_rule({ match = match, tag = "+" .. tag })
    end
end

local function create_tag(tag, rules)
    local rule = { match = { tag = tag } }
    for k, v in pairs(rules) do
        rule[k] = v
    end
    hl.window_rule(rule)
end

local opaque_tag        = "opaque"
local float_tag         = "float"
local float_50_60_tag   = "float_50_60"
local float_60_70_tag   = "float_60_70"
local float_70_80_tag   = "float_70_80"
local game_tag          = "game"
local xwl_popup_tag     = "xwl_popup"
local sysmon_tag        = "system_monitor"
local music_tag         = "music_player"
local communication_tag = "communication_app"
local todo_tag          = "todo_app"


----------------------
---- Window rules ----
----------------------

-- Opacidad global (todo menos fullscreen)
hl.window_rule({ match = { fullscreen = false }, opacity = vars.windowOpacity .. " override" })

-- Centrar flotantes, salvo las de xwayland (sus popups cuentan como ventanas)
hl.window_rule({ match = { float = true, xwayland = false }, center = true })

-- Picture in picture
hl.window_rule({
    match             = { title = "Picture(-| )in(-| )[Pp]icture" },
    move              = "(monitor_w*0.98-window_w) (monitor_h*0.97-window_h)",
    float             = true,
    pin               = true,
    keep_aspect_ratio = true,
})

-- LibreOffice: opacidad propia (portado de la config de caelestia)
hl.window_rule({ match = { class = "^libreoffice.*", fullscreen = false }, opacity = "0.8 override" })

-- Zoom: todo flotante. No se lleva bien con el tiling y las reglas de posición no
-- alcanzaban para dejar clickeable la barra de control del compartir pantalla.
-- Sin tag: los create_tag de abajo ya corrieron cuando se evalúa esto.
hl.window_rule({ match = { class = "zoom" }, float = true })


----------------------
---- Tagged rules ----
----------------------

-- Opacas (usan transparencia nativa o no queremos blur)
tagged_rule(opaque_tag, {
    "feh|imv|swappy",                                  -- Visores de imagen
    "krita|gimp|inkscape|darktable",                   -- Editores de imagen
    "resolve|kdenlive",                                -- Editores de video
    "blender|godot",                                   -- 3D
    "(steam_app_(default|[0-9]+))|gamescope",          -- Juegos
}, "class")

-- Flotantes
tagged_rule(float_tag, {
    "yad|zenity",                                      -- Diálogos
    "wev",                                             -- Detector de input
    "org.gnome.FileRoller|file-roller",                -- Gestor de archivos comprimidos
    "blueman-manager",                                 -- Bluetooth GUI
    "feh|imv",                                         -- Visores de imagen
    "xdg-desktop-portal-gtk",                          -- Portal GTK
}, "class")
tagged_rule(float_tag, {
    "File (Operation|Upload)( Progress)?",             -- Progreso de operaciones de archivo
    ".* Properties",                                   -- Propiedades de archivo
}, "title")

-- Flotantes con tamaño
-- 50% x 60%
tagged_rule(float_50_60_tag, {
    "nwg-look",                                        -- Gestor de temas GTK
    "system-config-printer",                           -- Config de impresoras
}, "class")

-- 60% x 70%
tagged_rule(float_60_70_tag, {
    "org.pulseaudio.pavucontrol|com.saivert.pwvucontrol", -- Control de audio
}, "class")
tagged_rule(float_60_70_tag, {
    "(Select|Open)( a)? (File|Folder)(s)?",            -- Diálogos de archivo
    "Save As",                                         -- Diálogos de guardado
    "bluetui|bluetuith",                               -- Bluetooth TUI
}, "title")
tagged_rule(float_60_70_tag, {
    { class = "kitty", title = "nmtui" },              -- Gestor de red TUI
})

-- 70% x 80%
tagged_rule(float_70_80_tag, {
    "org.gnome.Settings",                              -- Ajustes del sistema
}, "class")

-- Juegos
tagged_rule(game_tag, {
    "steam_app_[0-9]+",                                -- Juegos de Steam
    "steam_app_default",                               -- Juegos de Lutris
    "gamescope",                                       -- Gamescope
})

-- Popups de XWayland (evitar artefactos visuales)
tagged_rule(xwl_popup_tag, {
    { xwayland = true, title = "win[0-9]+" },
})

-- Ueberzugpp (previews de imágenes en terminal)
hl.window_rule({ match = { class = "ueberzugpp_.*" }, float = true, no_initial_focus = true })


-----------------------------
---- Special workspaces -----
-----------------------------

tagged_rule(sysmon_tag, { "btop" }, "class")
tagged_rule(music_tag, {
    "feishin|Supersonic|Plexamp",                      -- Self hosted
    "Spotify",                                         -- Spotify
    "com.github.th-ch.youtube-music",                  -- YouTube Music
}, "class")
tagged_rule(music_tag, {
    "Spotify|Spotify Free",                            -- Spotify wayland no expone clase
}, "initial_title")
tagged_rule(communication_tag, {
    "discord|equibop|vesktop",                         -- Clientes de Discord
    "whatsapp",                                        -- WhatsApp
}, "class")
tagged_rule(todo_tag, {
    "todoist",                                         -- Todoist
    "md.obsidian.Obsidian",                            -- Obsidian (notas rápidas)
}, "class")


-------------------
---- Steam --------
-------------------

hl.window_rule({ match = { class = "steam" }, rounding = 10 })
tagged_rule(float_tag, { { class = "steam", title = "Friends List" } })
tagged_rule(xwl_popup_tag, { { class = "steam", title = "" } })
-- Propiedades/diálogos de juego: su título es el nombre del juego, así que se matchea
-- todo menos la ventana principal, la lista de amigos y los popups de título vacío.
hl.window_rule({
    match  = { class = "steam", title = "negative:^(Steam|Friends List|)$" },
    float  = true,
    center = true,
})


-------------------------
---- Tag definitions ----
-------------------------
-- Tienen que ir después de TODOS los usos de tags. Cosas de Hyprland.

create_tag(opaque_tag, { opaque = true })
create_tag(float_tag, { float = true })
create_tag(float_50_60_tag, { float = true, size = "(monitor_w*0.5) (monitor_h*0.6)", center = true })
create_tag(float_60_70_tag, { float = true, size = "(monitor_w*0.6) (monitor_h*0.7)", center = true })
create_tag(float_70_80_tag, { float = true, size = "(monitor_w*0.7) (monitor_h*0.8)", center = true })
create_tag(game_tag, { immediate = true, idle_inhibit = "always" })
create_tag(xwl_popup_tag, {
    no_dim    = true,
    no_shadow = true,
    no_blur   = true,
    opaque    = true,
    rounding  = math.min(10, vars.windowRounding),
})
create_tag(sysmon_tag, { workspace = "special:sysmon" })
create_tag(music_tag, { workspace = "special:music" })
create_tag(communication_tag, { workspace = "special:communication" })
create_tag(todo_tag, { workspace = "special:todo" })


-------------------------
---- Workspace rules ----
-------------------------

hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = vars.singleWindowGapsOut })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = vars.singleWindowGapsOut })


---------------------
---- Layer rules ----
---------------------

hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "wayfreeze" }, animation = "fade" })

-- Rofi. El .conf viejo decía namespace "launcher", que no matchea nada: el namespace
-- real de Rofi vía wlr-layer-shell es "rofi" (verificado con `hyprctl layers`).
hl.layer_rule({ match = { namespace = "rofi" }, animation = "slide", blur = true })

hl.layer_rule({ match = { namespace = "swaync-notification-window" }, animation = "slide right" })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, animation = "slide right" })

hl.layer_rule({ match = { namespace = "waybar" }, animation = "slide", blur = true })
