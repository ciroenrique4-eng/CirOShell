-- Self-check de la config: carga todos los módulos con un `hl` simulado.
-- Atrapa errores de sintaxis, requires rotos y nils antes de reiniciar la sesión.
--
--   cd ~/.config/hypr && lua test-config.lua
--
-- No valida que los nombres de opciones/dispatchers existan en Hyprland: eso solo
-- lo dice el compositor. Verificar ahí con `hyprctl getoption <seccion>:<opcion>`.

local seen = { config = 0, env = 0, bind = 0, window_rule = 0, layer_rule = 0 }
local errors = {}

-- Cualquier acceso devuelve algo invocable y a la vez indexable, así
-- hl.dsp.window.close() y hl.dsp.focus({...}) funcionan sin enumerarlos.
local anything
anything = setmetatable({}, {
    __index = function() return anything end,
    __call  = function() return anything end,
})

-- Estado simulado del compositor. Valores realistas para que las funciones de
-- keybinds.lua recorran su rama principal y no solo la guarda de nil.
local fake = {
    dsp                         = anything,
    get_active_window           = function() return { size = { x = 800, y = 600 }, class = "kitty" } end,
    get_windows                 = function() return { { class = "kitty" }, { class = "btop" } } end,
    get_active_special_workspace = function() return nil end,
    get_active_workspace        = function() return { id = 1 } end,
    get_active_monitor          = function() return { width = 1920, height = 1080, scale = 1, x = 0, y = 0 } end,
}

local hl_stub = setmetatable({}, {
    __index = function(_, key)
        if fake[key] then return fake[key] end

        return function(...)
            if seen[key] then seen[key] = seen[key] + 1 end

            -- hl.on(evento, fn) y hl.bind(tecla, fn): ejecutar el callback, que es
            -- donde vive la lógica (execs.lua, toggle_special, resize_active_window).
            local args = { ... }
            for _, a in ipairs(args) do
                if type(a) == "function" then
                    local ok, err = pcall(a)
                    if not ok then errors[#errors + 1] = tostring(args[1]) .. ": " .. tostring(err) end
                end
            end
            return anything
        end
    end,
})

_G.hl = hl_stub

-- Hyprland resuelve los require relativos al directorio de la config.
local dir = arg[0]:match("(.*)/") or "."
package.path = dir .. "/?.lua;" .. package.path

-- current.lua lo genera Matugen; si no existe todavía, se usan los defaults.
if not io.open(dir .. "/scheme/current.lua") then
    local src = assert(io.open(dir .. "/scheme/default.lua")):read("*a")
    local out = assert(io.open(dir .. "/scheme/current.lua", "w"))
    out:write(src)
    out:close()
end

dofile(dir .. "/hyprland.lua")

if #errors > 0 then
    for _, e in ipairs(errors) do io.stderr:write("FALLO  " .. e .. "\n") end
    os.exit(1)
end

assert(seen.config > 0, "ningún hl.config() ejecutado")
assert(seen.env > 0, "ningún hl.env() ejecutado")
assert(seen.bind > 50, "se esperaban >50 binds, hubo " .. seen.bind)
assert(seen.window_rule > 20, "se esperaban >20 window rules, hubo " .. seen.window_rule)
assert(seen.layer_rule > 0, "ninguna layer rule")

print(("ok  config=%d env=%d binds=%d window_rules=%d layer_rules=%d")
    :format(seen.config, seen.env, seen.bind, seen.window_rule, seen.layer_rule))
