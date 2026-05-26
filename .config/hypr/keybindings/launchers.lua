local programs = require("programs")
local mainMod = "SUPER"

-- Launchers
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd(programs.spotify))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(programs.appLauncher))
hl.bind(mainMod .. " + SUPER_L", hl.dsp.exec_cmd("~/.config/eww/launch_left"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("~/.local/bin/end-rs history toggle"))
