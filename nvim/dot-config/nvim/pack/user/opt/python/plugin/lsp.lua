vim.lsp.config("pyrefly", {
  cmd = { "uv", "tool", "run", "pyrefly", "lsp" },
  init_options = {
    pyrefly = {
      typeCheckingMode = "auto",
      analysis = {
        showHoverGoToLinks = false,
      },
    },
  },
})
vim.lsp.enable("pyrefly")
