# shellcheck shell=bash

echo "Remove the /etc lid switch drop-in now that logind-lid-cfg ships it"

lid_conf=/etc/systemd/logind.conf.d/10-ignore-lid.conf

# Removing the /etc copy before the package is installed would make closing the
# lid suspend the laptop again. Fail so the migration stays pending.
if ! pacman -Q logind-lid-cfg &>/dev/null; then
  echo "Install logind-lid-cfg first: cd ~/.dotfiles/my-pkgs/logind-lid-cfg && makepkg -si"
  exit 1
fi

# The /etc copy overrides the packaged file of the same name, so later package
# changes would never take effect.
if [[ -f $lid_conf ]]; then
  sudo rm "$lid_conf"
  sudo systemctl kill -s HUP systemd-logind
fi
