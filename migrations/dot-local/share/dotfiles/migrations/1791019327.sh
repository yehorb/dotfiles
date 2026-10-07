# shellcheck shell=bash

echo "Disable NVIDIA systemd sleep services"

# With nvidia-open and NVreg_UseKernelSuspendNotifiers=1 (set by nvidia-utils),
# nvidia.ko preserves video memory on its own. These units only add the
# nvidia-sleep.sh VT switch, which leaves Hyprland without outputs on resume.
for unit in nvidia-suspend nvidia-resume nvidia-hibernate nvidia-suspend-then-hibernate; do
  if systemctl is-enabled --quiet "$unit.service" 2>/dev/null; then
    sudo systemctl disable "$unit.service"
  fi
done
