local scheme = require("scheme.current")

hl.config({
    misc = {
        vrr                          = 0, -- default de Hyprland; explícito porque en este panel el VRR causa flicker

        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,

        disable_hyprland_logo        = true,
        force_default_wallpaper      = 0,

        on_focus_under_fullscreen    = 2,
        allow_session_lock_restore   = true,
        middle_click_paste           = false,
        focus_on_activate            = true,
        session_lock_xray            = true,

        mouse_move_enables_dpms      = true,
        key_press_enables_dpms       = true,

        background_color             = "rgb(" .. scheme.surfaceContainer .. ")",
    },

    render = {
        -- Una ventana fullscreen sola va directa al plano del display: el compositor
        -- deja de componer. Medido: Hyprland baja de 14.9% a 7.5% de CPU, de 23.1% a 0%
        -- de GPU y de 9.0W a 3.4W. Requiere fullscreen real, no ventana sin bordes.
        -- Verificar: hyprctl monitors | grep -E "solitary|tearing|directScanout"
        direct_scanout = 1,
    },

    debug = {
        error_position = 1,
    },
})
