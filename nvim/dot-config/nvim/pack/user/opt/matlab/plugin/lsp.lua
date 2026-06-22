-- - Download the language server
--
--    `git clone https://github.com/mathworks/MATLAB-language-server.git`
-- - In the cloned or unzipped directory
--
--    ```bash
--    npm run project-install
--    npm run compile
--    npm run package
--    pnpm add --global .  # install executable and add to $PATH
--    ```

vim.lsp.config("matlab_ls", {
  settings = {
    MATLAB = {
      installPath = "/usr/local/MATLAB/R2025b",
    },
  },
})
vim.lsp.enable("matlab_ls")
