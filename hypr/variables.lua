local scheme = require("scheme.current")

return {
    ------------------
    ---- HYPRLAND ----
    ------------------

    -- Apps
    terminal              = "kitty",
    browser               = "zen-browser",
    -- ponytail: el .conf viejo hacía `exec, code` a pelo, pero `code` no está instalado
    -- en este equipo (tampoco codium ni el flatpak). nvim sí, y necesita una terminal.
    editor                = "kitty -e nvim",
    fileExplorer          = "hyprfm",
    audioSettings         = "pavucontrol",

    -- Touchpad
    touchpadDisableTyping = false,
    touchpadScrollFactor  = 0.3,
    workspaceSwipeFingers = 4,
    gestureFingers        = 3,

    -- Blur
    blurEnabled           = true,
    blurSpecialWs         = true,
    blurPopups            = false,
    blurInputMethods      = true,
    blurSize              = 1,
    blurPasses            = 4,
    blurXray              = false,
    blurNewOptimizations  = true,

    -- Sombras
    shadowEnabled         = false,
    shadowRange           = 2,
    shadowRenderPower     = 3,
    shadowColour          = "rgba(" .. scheme.surface .. "d4)",

    -- Gaps
    workspaceGaps         = 10,
    windowGapsIn          = 5,
    windowGapsOut         = 10,
    singleWindowGapsOut   = 10,

    -- Ventanas
    windowOpacity         = 0.92,
    windowRounding        = 8,
    windowBorderSize      = 2,
    activeWindowBorderColour   = "rgba(" .. scheme.primary .. "e6)",
    inactiveWindowBorderColour = "rgba(" .. scheme.onSurfaceVariant .. "11)",

    -- Misc
    volumeStep            = 5,
    volumeMax             = 100,
    cursorTheme           = "Bibata-Modern-Classic",
    cursorSize            = 24,
    sleepCmd              = "systemctl suspend-then-hibernate",

    ------------------
    ---- KEYBINDS ----
    ------------------

    -- Solo el modificador: los binds reales son mod + 0-9.
    kbGoToWs              = "SUPER",
    kbMoveWinToWs         = "SUPER + ALT",

    -- Workspaces
    kbNextWs              = { "CTRL + SUPER + right", "SUPER + mouse_up" },
    kbPrevWs              = { "CTRL + SUPER + left", "SUPER + mouse_down" },
    kbMoveWinToWsNext     = { "SUPER + ALT + Page_Down", "SUPER + ALT + mouse_up" },
    kbMoveWinToWsPrev     = { "SUPER + ALT + Page_Up", "SUPER + ALT + mouse_down" },
    kbToggleSpecialWs     = "SUPER + S",
    kbMoveWinToWsSpecial  = "CTRL + SUPER + SHIFT + up",
    kbMoveWinFromWsSpecial = "CTRL + SUPER + SHIFT + down",

    -- Special workspaces
    kbSysmonWs            = "CTRL + SHIFT + Escape",
    kbMusicWs             = "SUPER + M",
    kbCommunicationWs     = "SUPER + D",
    kbTodoWs              = "SUPER + R",

    -- Ventanas
    kbMoveWindow          = "SUPER + Z",
    kbResizeWindow        = "SUPER + X",
    kbCenterWindow        = "CTRL + SUPER + Backslash",
    kbPinWindow           = "SUPER + P",
    kbWindowFullscreen    = "SUPER + F",
    kbWindowBorderedFullscreen = "SUPER + ALT + F",
    kbToggleWindowFloating = "SUPER + ALT + Space",
    kbCloseWindow         = "SUPER + Q",
    kbWindowGroupCycleNext = "ALT + TAB",
    kbWindowGroupCyclePrev = "SHIFT + ALT + TAB",
    kbToggleGroup         = "SUPER + Comma",
    kbUngroup             = "SUPER + U",

    -- Apps
    kbTerminal            = "SUPER + T",
    kbBrowser             = "SUPER + W",
    kbEditor              = "SUPER + C",
    kbFileExplorer        = "SUPER + E",
    kbGithubDesktop       = "SUPER + G",

    -- Paneles de Rofi
    kbLauncher            = "SUPER + SUPER_L",
    kbScriptsMenu         = "SUPER + O",
    kbWallpapers          = "SUPER + SHIFT + W",
    kbColorMode           = "SUPER + SHIFT + D",
    kbClipboard           = "SUPER + V",

    -- Notificaciones (swaync)
    kbShowSidebar         = "SUPER + N",
    kbClearNotifs         = "CTRL + ALT + C",

    -- Utilidades
    kbScreenshot          = "Print",
    kbScreenshotRegion    = "SUPER + SHIFT + S",
    kbScreenshotSave      = "SUPER + SHIFT + ALT + S",
    kbColorPicker         = "SUPER + SHIFT + C",
    kbLock                = "SUPER + L",
    kbSleep               = "SUPER + SHIFT + L",
    kbVolumeMute          = "SUPER + SHIFT + M",

    -- Media
    kbMediaToggle         = "CTRL + SUPER + Space",
    kbMediaNext           = "CTRL + SUPER + Equal",
    kbMediaPrev           = "CTRL + SUPER + Minus",
}
