-- Show hidden files and follow symlinks in file/grep pickers, so symlinked,
-- dot-prefixed dirs (e.g. .agents/.scratch) are searchable. Paths ignored by
-- git can be re-included per repo with a `.ignore` file (`!/path`).
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = { hidden = true, follow = true },
        grep = { hidden = true, follow = true },
      },
    },
  },
}
