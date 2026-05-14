-- Extra autostart processes.
-- o.launch_on_start("my-service")

-- Stop locking computer when idle by default
hl.on("hyprland.start", function()
  hl.exec_cmd("bash -lc 'sleep 2; pkill -x hypridle; pkill -RTMIN+9 waybar'")
end)
