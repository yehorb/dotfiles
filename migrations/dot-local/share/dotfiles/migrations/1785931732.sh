# shellcheck shell=bash

echo "Back up the encrypted Login keyring in favor of Omarchy's Default keyring"

login_keyring="$HOME/.local/share/keyrings/login.keyring"

if [[ -f $login_keyring ]]; then
  mv "$login_keyring" "$login_keyring.pre-keyring-fix"
fi

echo "The keyring daemon will pick up this change after the next logout or reboot."
