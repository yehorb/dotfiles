local current_theme_path = vim.fs.normalize("$HOME/.config/omarchy/current/theme/neovim.lua")

if vim.uv.fs_stat(current_theme_path) then
  return dofile(current_theme_path)
else
  return {}
end
