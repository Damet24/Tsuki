local mainMod = "SUPER"

-- Navigation (Colemak)
hl.bind(mainMod .. " + N", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + U", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + E", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
