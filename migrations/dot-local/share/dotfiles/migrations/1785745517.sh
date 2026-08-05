echo "Keep the laptop running when the lid is closed"

sudo mkdir -p /etc/systemd/logind.conf.d
sudo tee /etc/systemd/logind.conf.d/10-ignore-lid.conf >/dev/null <<'EOF'
[Login]
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
EOF

sudo systemctl kill -s HUP systemd-logind
