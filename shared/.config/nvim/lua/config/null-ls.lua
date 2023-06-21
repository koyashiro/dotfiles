return function()
  local null_ls = require("null-ls")

  vim.api.nvim_create_user_command("Format", function()
    vim.lsp.buf.format({
      async = false,
      filter = function(c)
        return c.name == "null-ls"
      end,
    })
  end, {})

  null_ls.setup({
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    sources = {
      -- Code Actions
      null_ls.builtins.code_actions.eslint,
      null_ls.builtins.code_actions.shellcheck,

      -- Diagnostics
      null_ls.builtins.diagnostics.actionlint,
      null_ls.builtins.diagnostics.eslint,
      null_ls.builtins.diagnostics.golangci_lint,
      null_ls.builtins.diagnostics.hadolint,
      null_ls.builtins.diagnostics.luacheck,
      null_ls.builtins.diagnostics.markdownlint,
      null_ls.builtins.diagnostics.shellcheck,
      null_ls.builtins.diagnostics.stylelint,

      -- Formatting
      null_ls.builtins.formatting.clang_format,
      null_ls.builtins.formatting.gofmt,
      null_ls.builtins.formatting.prettierd,
      null_ls.builtins.formatting.rustfmt,
      null_ls.builtins.formatting.shfmt,
      null_ls.builtins.formatting.stylua,
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          command = "Format",
        })
      end
    end,
  })
end
