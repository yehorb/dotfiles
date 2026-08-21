-- Options are automatically loaded before lazy.nvim startup.
require("config.remote_clipboard").setup()

vim.opt.relativenumber = false
vim.g.autoformat = false

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
