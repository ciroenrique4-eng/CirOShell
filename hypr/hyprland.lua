-- Punto de entrada de la config de Hyprland (sintaxis Lua, Hyprland >= 0.50).
-- Los módulos viven en hyprland/*.lua y se cargan con require, no con `source`.

local hypr = (os.getenv("HOME")) .. "/.config/hypr"

-- Copia src a dst solo si dst no existe (para no pisar la paleta de Matugen).
local function maybe_copy(src, dst)
    local out = io.open(dst)
    if out then
        out:close()
        return
    end

    local input = io.open(src, "r")
    if not input then return end

    out = io.open(dst, "w")
    if out then
        out:write(input:read("*a"))
        out:close()
    end
    input:close()
end

-- Paleta: si Matugen todavía no generó current.lua, arrancar con los defaults.
maybe_copy(hypr .. "/scheme/default.lua", hypr .. "/scheme/current.lua")

-- Monitores. El primero es el catch-all; los siguientes pisan por output.
-- ponytail: position = "auto" en vez de las coordenadas fijas del hyprland.conf viejo
-- (-384x0 / 1536x0), que no correspondían a este equipo.
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "1920x1080@120.00", position = "auto", scale = 1 })

-- Configs
require("hyprland.env")
require("hyprland.general")
require("hyprland.input")
require("hyprland.misc")
require("hyprland.animations")
require("hyprland.decoration")
require("hyprland.group")
require("hyprland.execs")
require("hyprland.rules")
require("hyprland.keybinds")

-- XWayland
hl.config({
    xwayland = {
        force_zero_scaling = true,
    },
})
