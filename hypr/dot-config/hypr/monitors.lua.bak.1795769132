-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- XWayland apps (Steam) get no fractional scaling with force_zero_scaling, and
-- GDK_SCALE only takes integers. Keep it at 1 and let them scale via Xft.dpi.
local omarchy_gdk_scale = 1
local omarchy_monitor_scale = "auto"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Xft.dpi = 96 * scale. XWayland has a single DPI, so with several monitors
-- the smallest scale wins. Rerun on reload to follow hyprdynamicmonitors profiles.
local function set_xft_dpi()
  local scale
  for _, monitor in ipairs(hl.get_monitors()) do
    scale = math.min(scale or monitor.scale, monitor.scale)
  end
  if scale then
    hl.exec_cmd(string.format("echo 'Xft.dpi: %d' | xrdb -merge", math.floor(scale * 96 + 0.5)))
  end
end
hl.on("hyprland.start", set_xft_dpi)
hl.on("config.reloaded", set_xft_dpi)

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

require("hypr._monitors")
