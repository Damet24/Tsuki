local mainMod = "SUPER"

-- System
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("hyprlock"))

local screenshotPath = "$HOME/Pictures/Screenshots"

-- Screenshots
hl.bind(mainMod .. " + F10", hl.dsp.exec_cmd("hyprshot -m window -o " .. screenshotPath))
hl.bind(mainMod .. " + F11", hl.dsp.exec_cmd("hyprshot -m output -m DP-1 -o " .. screenshotPath))
hl.bind(mainMod .. " + F12", hl.dsp.exec_cmd("hyprshot -m region -o " .. screenshotPath))



hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
