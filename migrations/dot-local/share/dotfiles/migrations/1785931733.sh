# shellcheck shell=bash

echo "Disable XRDP root login"

xrdp_sesman=/etc/xrdp/sesman.ini

if [[ -f $xrdp_sesman ]]; then
  sudo cp --archive --no-clobber "$xrdp_sesman" "$xrdp_sesman.pre-disable-root-login"
  sudo sed -i -E 's/^[[:space:]]*AllowRootLogin[[:space:]]*=.*/AllowRootLogin=false/' "$xrdp_sesman"
fi
