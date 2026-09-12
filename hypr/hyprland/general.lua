local vars = require("variables")

hl.config({
    general = {
        layout                  = "dwindle",

        resize_on_border        = true,
        extend_border_grab_area = 10, -- área invisible extra alrededor del borde
        hover_icon_on_border    = true, -- cambia el cursor al pasar por el borde

        allow_tearing           = true, -- habilita la regla `immediate` de los juegos (rules.lua)

        gaps_workspaces         = vars.workspaceGaps,
        gaps_in                 = vars.windowGapsIn,
        gaps_out                = vars.windowGapsOut,
        border_size             = vars.windowBorderSize,

        col                     = {
            active_border   = vars.activeWindowBorderColour,
            inactive_border = vars.inactiveWindowBorderColour,
        },
    },

    dwindle = {
        preserve_split = true,
        smart_split    = false,
        smart_resizing = true,
    },
})
