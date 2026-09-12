local vars = require("variables")

local hypr    = (os.getenv("HOME")) .. "/.config/hypr"
local scripts = hypr .. "/scripts"

-- Flags (equivalen a los sufijos del .conf: bindl/binde/bindm/bindr)
local locked           = { locked = true }
local mouse            = { mouse = true }
local release          = { release = true }
local repeating        = { repeating = true }
local locked_repeating = { locked = true, repeating = true }

-- Acepta un string o un array de strings, para no repetir el bind a mano.
local function create_bind(keys, action, flags)
    if type(keys) ~= "table" then keys = { keys } end
    for _, key in ipairs(keys) do
        hl.bind(key, action, flags)
    end
end

-- Redimensiona la ventana activa un % de su tamaño actual.
local function resize_active_window(x, y)
    return function() -- función, para que hl la reevalúe en cada pulsación
        local win = hl.get_active_window()
        if win and win.size then
            hl.dispatch(hl.dsp.window.resize({
                x        = win.size.x * (x / 100),
                y        = win.size.y * (y / 100),
                relative = true,
            }))
        end
    end
end

-- Toggle de workspace especial. Si se le pasa `cmd`, lo lanza ahí cuando no
-- hay ninguna ventana de esa clase abierta todavía.
local function toggle_special(name, class, cmd)
    return function()
        local active = hl.get_active_special_workspace()
        if active and active.name == "special:" .. name then
            return hl.dispatch(hl.dsp.workspace.toggle_special(name))
        end

        hl.dispatch(hl.dsp.focus({ workspace = "special:" .. name }))

        if cmd then
            for _, win in ipairs(hl.get_windows() or {}) do
                if win.class and string.find(win.class, class) then return end
            end
            hl.dispatch(hl.dsp.exec_cmd(cmd, { workspace = "special:" .. name }))
        end
    end
end


--------------
---- Apps ----
--------------

create_bind(vars.kbTerminal, hl.dsp.exec_cmd(vars.terminal))
create_bind(vars.kbBrowser, hl.dsp.exec_cmd(vars.browser))
create_bind(vars.kbEditor, hl.dsp.exec_cmd(vars.editor))
create_bind(vars.kbFileExplorer, hl.dsp.exec_cmd(vars.fileExplorer))
create_bind(vars.kbGithubDesktop, hl.dsp.exec_cmd("github-desktop"))


-----------------------
---- Paneles: Rofi ----
-----------------------

-- Launcher: toggle en release, como el `bindr` del .conf.
create_bind(vars.kbLauncher, hl.dsp.exec_cmd("pkill rofi || rofi -show drun"), release)
-- El modo `myscripts` lo define rofi/config.rasi y apunta a hypr/scripts_menu.sh.
create_bind(vars.kbScriptsMenu, hl.dsp.exec_cmd("rofi -show myscripts"))
create_bind(vars.kbWallpapers, hl.dsp.exec_cmd(scripts .. "/'󰸉 Fondos de Pantalla.sh'"))
create_bind(vars.kbColorMode, hl.dsp.exec_cmd(scripts .. "/'󰔎 Modo de Color.sh'"))
create_bind(vars.kbClipboard, hl.dsp.exec_cmd(scripts .. "/portapapeles.sh"))


----------------------------
---- Notificaciones ---------
----------------------------

create_bind(vars.kbShowSidebar, hl.dsp.exec_cmd("swaync-client -t -sw"))
create_bind(vars.kbClearNotifs, hl.dsp.exec_cmd("swaync-client -C"), locked)


---------------------
---- Utilidades -----
---------------------

create_bind(vars.kbScreenshot, hl.dsp.exec_cmd("grimblast copy screen"), locked)
create_bind(vars.kbScreenshotRegion, hl.dsp.exec_cmd("grimblast copy area"))
create_bind(vars.kbScreenshotSave, hl.dsp.exec_cmd("grimblast save area"))
create_bind(vars.kbColorPicker, hl.dsp.exec_cmd("hyprpicker -a"))
create_bind(vars.kbLock, hl.dsp.exec_cmd("hyprlock"))
create_bind(vars.kbSleep, hl.dsp.exec_cmd(vars.sleepCmd), locked)


-----------------
---- Volumen ----
-----------------

create_bind({ vars.kbVolumeMute, "XF86AudioMute" },
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked)
create_bind("XF86AudioMicMute",
    hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), locked)
create_bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l " ..
    (vars.volumeMax / 100) .. " @DEFAULT_AUDIO_SINK@ " .. vars.volumeStep .. "%+"
), locked_repeating)
create_bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ " ..
    vars.volumeStep .. "%-"
), locked_repeating)


---------------
---- Media ----
---------------

create_bind({ vars.kbMediaToggle, "XF86AudioPlay", "XF86AudioPause" },
    hl.dsp.exec_cmd("playerctl play-pause"), locked)
create_bind({ vars.kbMediaNext, "XF86AudioNext" }, hl.dsp.exec_cmd("playerctl next"), locked)
create_bind({ vars.kbMediaPrev, "XF86AudioPrev" }, hl.dsp.exec_cmd("playerctl previous"), locked)
create_bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"), locked)


----------------
---- Brillo ----
----------------

create_bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 10%+"), locked_repeating)
create_bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 10%-"), locked_repeating)


------------------
---- Ventanas ----
------------------

for _, dir in ipairs({ "left", "right", "up", "down" }) do
    create_bind("SUPER + " .. dir, hl.dsp.focus({ direction = dir }))
    create_bind("SUPER + SHIFT + " .. dir, hl.dsp.window.move({ direction = dir }))
end

create_bind("SUPER + ALT + left", resize_active_window(-10, 0), repeating)
create_bind("SUPER + ALT + right", resize_active_window(10, 0), repeating)
create_bind("SUPER + ALT + up", resize_active_window(0, -10), repeating)
create_bind("SUPER + ALT + down", resize_active_window(0, 10), repeating)

-- ponytail: el .conf tenía además un submap "resize" en SUPER+X. Se reemplaza por el
-- resize con ratón de Hyprland, que ya cubre lo mismo sin un modo aparte; el teclado
-- sigue en SUPER+ALT+flechas.
create_bind({ vars.kbMoveWindow, "SUPER + mouse:272" }, hl.dsp.window.drag(), mouse)
create_bind({ vars.kbResizeWindow, "SUPER + mouse:273" }, hl.dsp.window.resize(), mouse)

create_bind(vars.kbCenterWindow, hl.dsp.window.center())
create_bind(vars.kbWindowFullscreen, hl.dsp.window.fullscreen({ mode = "fullscreen" }))
create_bind(vars.kbWindowBorderedFullscreen, hl.dsp.window.fullscreen({ mode = "maximized" }))
create_bind(vars.kbToggleWindowFloating, hl.dsp.window.float())
create_bind(vars.kbCloseWindow, hl.dsp.window.close())
create_bind(vars.kbPinWindow, hl.dsp.window.pin())


----------------------------
---- Grupos de ventanas ----
----------------------------

create_bind(vars.kbWindowGroupCycleNext, hl.dsp.window.cycle_next(), repeating)
create_bind(vars.kbWindowGroupCyclePrev, hl.dsp.window.cycle_next({ next = false }), repeating)
create_bind("CTRL + ALT + TAB", hl.dsp.group.next(), repeating)
create_bind("CTRL + SHIFT + ALT + TAB", hl.dsp.group.prev(), repeating)
create_bind(vars.kbToggleGroup, hl.dsp.group.toggle())
create_bind(vars.kbUngroup, hl.dsp.window.move({ out_of_group = true }))


--------------------
---- Workspaces ----
--------------------

for i = 1, 10 do
    local key = i % 10 -- el 10 va en la tecla 0
    create_bind(vars.kbGoToWs .. " + " .. key, hl.dsp.focus({ workspace = i }))
    create_bind(vars.kbMoveWinToWs .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

create_bind(vars.kbPrevWs, hl.dsp.focus({ workspace = "-1" }), repeating)
create_bind(vars.kbNextWs, hl.dsp.focus({ workspace = "+1" }), repeating)
create_bind(vars.kbMoveWinToWsPrev, hl.dsp.window.move({ workspace = "-1" }), repeating)
create_bind(vars.kbMoveWinToWsNext, hl.dsp.window.move({ workspace = "+1" }), repeating)


-------------------------------
---- Workspaces especiales ----
-------------------------------

create_bind(vars.kbToggleSpecialWs, hl.dsp.workspace.toggle_special("special"))
create_bind(vars.kbMoveWinToWsSpecial, hl.dsp.window.move({ workspace = "special:special" }))
create_bind(vars.kbMoveWinFromWsSpecial, hl.dsp.window.move({ workspace = "e+0" }))

create_bind(vars.kbSysmonWs, toggle_special("sysmon", "btop", "kitty --class btop -e btop"))
create_bind(vars.kbMusicWs, toggle_special("music", "feishin", "feishin"))
-- Sin comando: la app se lanza a mano y las reglas de rules.lua la mandan al special.
create_bind(vars.kbCommunicationWs, toggle_special("communication"))
create_bind(vars.kbTodoWs, toggle_special("todo"))
