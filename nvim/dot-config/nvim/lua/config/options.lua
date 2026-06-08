-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.relativenumber = false

vim.o.list = true
vim.opt.listchars = {
  -- Whitespace
  nbsp = "␣",
  tab = "→ ",
  trail = "␠",
  -- SpecialKey
  conceal = "⬚",
  extends = "…",
  precedes = "…",
}
vim.schedule(function() -- Defer execution after init is done (to aviod overrides during colorscheme selection)
  -- Highlight nonprinting characters
  vim.cmd("highlight! link Whitespace WarningMsg")
  vim.cmd("highlight! link SpecialKey ErrorMsg")
end)
