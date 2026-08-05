# shellcheck shell=bash

echo "Align XRDP and SDDM autologin with Omarchy's default keyring"

xrdp_pam=/etc/pam.d/xrdp-sesman
sddm_autologin_pam=/etc/pam.d/sddm-autologin

if [[ -f $xrdp_pam ]]; then
  sudo cp --archive --no-clobber "$xrdp_pam" "$xrdp_pam.pre-keyring-fix"

  # XRDP still authenticates through system-remote-login. Avoid creating or
  # unlocking a separate wallet from its password-authenticated XFCE session.
  sudo sed -i -E \
    '/^[[:space:]]*-?(auth|session)[[:space:]]+.*pam_(gnome_keyring|kwallet5)\.so([[:space:]]|$)/d' \
    "$xrdp_pam"
fi

if [[ -f $sddm_autologin_pam ]]; then
  sudo cp --archive --no-clobber "$sddm_autologin_pam" "$sddm_autologin_pam.pre-keyring-fix"

  # Autologin has no password to unlock a keyring. Keep the GNOME Keyring
  # session hook so it can expose Omarchy's passwordless Default keyring.
  sudo sed -i -E \
    -e '/^[[:space:]]*-?auth[[:space:]]+.*pam_(gnome_keyring|kwallet5)\.so([[:space:]]|$)/d' \
    -e '/^[[:space:]]*-?session[[:space:]]+.*pam_kwallet5\.so([[:space:]]|$)/d' \
    "$sddm_autologin_pam"
fi
