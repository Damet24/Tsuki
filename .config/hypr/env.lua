local programs = require("programs")

-- =========================
-- Variables generales
-- =========================
hl.env("EDITOR", programs.editor)

-- =========================
-- Cursor
-- =========================
hl.env("XCURSOR_THEME", "Sweet-cursors")
hl.env("XCURSOR_SIZE", "20")

-- =========================
-- GTK / Tema
-- =========================
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("GDK_BACKEND", "wayland,x11,*")

-- =========================
-- Sesión Wayland / Hyprland
-- =========================
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- =========================
-- Firefox / Mozilla
-- =========================
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")

-- =========================
-- NVIDIA / Wayland
-- =========================
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Recomendadas para estabilidad
hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VRR_ALLOWED", "0")

-- GPU principal
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1")

-- =========================
-- Electron / Chromium
-- =========================
hl.env("NVD_BACKEND", "direct")

-- =========================
-- Qt
-- =========================
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

-- =========================
-- Clutter
-- =========================
hl.env("CLUTTER_BACKEND", "wayland")
