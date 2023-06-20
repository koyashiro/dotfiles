return function()
  require("lualine").setup({
    sections = {
      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic", "nvim_lsp" },
          sections = { "error", "warn", "info", "hint" },
          symbols = { error = " ", warn = " ", info = " ", hint = "" },
        },
      },
    },
  })
end
