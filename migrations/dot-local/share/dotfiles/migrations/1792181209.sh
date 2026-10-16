# shellcheck shell=bash

echo "Bind mount /usr/share/steam to /opt/steam for Flatpak apps"

# Flatpak refuses to share anything under /usr with the sandbox, so expose
# system-wide Steam compatibility tools through a path it can share.
fstab=/etc/fstab
source=/usr/share/steam
target=/opt/steam

if [[ ! -d $source ]]; then
  echo "$source does not exist, install a Steam compatibility tool package first" >&2
  exit 1
fi

if ! grep -qE "^[^#]*[[:space:]]${target}[[:space:]]" "$fstab"; then
  sudo cp --archive --no-clobber "$fstab" "$fstab.pre-opt-steam"
  printf '\n# %s\n%s\t%s\tnone\tbind,ro\t0 0\n' "$source" "$source" "$target" | sudo tee -a "$fstab" >/dev/null
fi

sudo mkdir -p "$target"
sudo systemctl daemon-reload

if ! mountpoint --quiet "$target"; then
  sudo mount "$target"
fi
