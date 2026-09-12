local vars = require("variables")

hl.config({
    input = {
        kb_layout          = "us,latam",
        kb_options         = "grp:alt_shift_toggle",
        numlock_by_default = true,
        repeat_delay       = 250,
        repeat_rate        = 35,

        focus_on_close     = 1,

        touchpad           = {
            natural_scroll       = true,
            disable_while_typing = vars.touchpadDisableTyping,
            scroll_factor        = vars.touchpadScrollFactor,
        },
    },

    binds = {
        scroll_event_delay = 0,
    },

    cursor = {
        hotspot_padding     = 1,
        inactive_timeout    = 5,
        -- ponytail: es un int (0/1/2), no un bool. 1 = desactivado, como pedía
        -- `no_hardware_cursors = true` del .conf viejo.
        no_hardware_cursors = 1,
    },

    gestures = {
        workspace_swipe_distance                 = 700,
        workspace_swipe_cancel_ratio             = 0.15,
        workspace_swipe_min_speed_to_force       = 5,
        workspace_swipe_direction_lock           = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new               = true,
    },
})

hl.gesture({ fingers = vars.workspaceSwipeFingers, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = vars.gestureFingers, direction = "up", action = "special", workspace_name = "special" })
