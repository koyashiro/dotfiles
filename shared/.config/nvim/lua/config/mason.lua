return function()
  require("mason").setup()

  require("mason-lspconfig").setup({
    -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
    ensure_installed = {
      "bashls",
      "clangd",
      "gopls",
      "jsonls",
      "lua_ls",
      "rust_analyzer",
      "taplo",
      "tailwindcss",
      "tsserver",
      "vimls",
      "volar",
      "yamlls",
    },
  })

  require("mason-lspconfig").setup_handlers({
    function(server_name)
      local opts = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }

      if server_name == "lua_ls" then
        opts.settings = {
          Lua = {
            format = {
              enable = false,
            },
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        }
      end

      require("lspconfig")[server_name].setup(opts)
    end,
  })
end
