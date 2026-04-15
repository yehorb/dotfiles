return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_a, {
        function()
          return vim.o.iminsert ~= 0 and vim.b.keymap_name or ""
        end,
      })
    end,
  },
}
