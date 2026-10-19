# shellcheck shell=bash

echo "Track pristine omarchy-nvim config on the omarchy-nvim branch of ~/.dotfiles"

pacman -Q omarchy omarchy-nvim >/dev/null || exit 1

if [[ $(readlink -f "$HOME/.config/nvim") != "$HOME/.dotfiles/nvim/dot-config/nvim" ]]; then
  echo "$HOME/.config/nvim is not stowed from $HOME/.dotfiles" >&2
  exit 1
fi

git -C "$HOME/.dotfiles" worktree add --orphan -b omarchy-nvim "$HOME/.cache/omarchy-nvim-vendor" || exit 1
bash "$HOME/.config/omarchy/hooks/post-update.d/snapshot-omarchy-nvim"
