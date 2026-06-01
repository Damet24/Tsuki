hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.layer_rule({
    name = "waybar-blur",
    match = { namespace = "^waybar$" },
    blur = false,
})

hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move = "20 monitor_h-120",
    float = true,
})

hl.layer_rule({
    name = "eww-blur",
    match = { namespace = "system_power" },
    blur = true,
})

-- =====================================================
-- ✔️ OSD (Eww volume / system overlays) click-through
-- =====================================================
hl.layer_rule({
    name = "osd-exclusive-off",
    match = { namespace = "^osd$" },
    ignore_alpha = 0.0,
})

-- =====================================================
-- ✔️ Browser popups centrados y flotantes
-- =====================================================
hl.window_rule({
    name = "bitwarden-auth",
    match = {
        class = "firefox|chromium|brave",
        initial_title = ".*Bitwarden.*|.*login.*|.*authorize.*",
    },
    float = true,
    center = true,
})

hl.window_rule({
    name = "file-picker-floating",
    match = {
        class = "xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-gnome",
    },
    float = true,
    center = true,
})

hl.window_rule({
    name = "file-picker-title-fallback",
    match = {
        title = "Open File|Save File|Select File|Choose File",
    },
    float = true,
    center = true,
})

hl.window_rule({
    name = "update-terminal",
    match = {
        class = "update-terminal",
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.35", "monitor_h * 0.35" },
})

hl.window_rule({
    name = "bitwarden-popup",
    match = {
        class = "brave-nngceckbapebfimnlniiiahkandclblb-Default",
        initial_title = "_crx_nngceckbapebfimnlniiiahkandclblb",
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.35", "monitor_h * 0.35" },
})

hl.window_rule({
    name = "Waypaper",
    match = {
        initial_title = "Waypaper",
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.5", "monitor_h * 0.5" },
})

hl.window_rule({
    name = "thunderbird new email",
    match = {
        initial_title = "Write:.*",
        class = "net.thunderbird.Thunderbird"
    },
    float = true,
    center = true,
    size = { "monitor_w * 0.6", "monitor_h * 0.6" },
})
