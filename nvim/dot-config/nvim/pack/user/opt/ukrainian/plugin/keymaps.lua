for _, lower in ipairs({ "a", "c", "i", "o", "r" }) do
  local upper = lower:upper()
  for _, key in ipairs({ lower, upper }) do
    vim.keymap.set(
      "n",
      "U" .. key,
      "<Cmd>set iminsert=1<CR>" .. key,
      { desc = "Toggle the use of typing language characters and enter Insert mode" }
    )
  end
end
for _, key in ipairs({ "<F4>", "<F5>", "<F6>" }) do
  vim.keymap.set({ "i", "c" }, key, "<C-^>", { desc = "Toggle the use of typing language characters" })
end
vim.keymap.set(
  "i",
  "<Esc>",
  "<Esc><Cmd>set iminsert=0<CR>",
  { desc = "Reset the 'iminsert' option to zero when leaving Insert mode" }
)
