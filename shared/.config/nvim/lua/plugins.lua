return {
  {
    "folke/lazy.nvim",
    version = "11.17.1",
  },
  {
    "folke/tokyonight.nvim",
    version = "4.11.0",
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    version = "0.10.0",
    event = "VeryLazy",
    build = ":TSUpdate",
    opts = {
      highlight = {
        enable = true,
      },
      auto_install = true,
      -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "go",
        "gomod",
        "gosum",
        "html",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "luadoc",
        "make",
        "markdown",
        "markdown_inline",
        "rust",
        "scss",
        "sql",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "yaml",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    version = "1.0.2",
    event = "VeryLazy",
    opts = {},
  },
  {
    "dinhhuy258/git.nvim",
    commit = "7354ed2efe31b979778cb62ffa2fa23df70eaf26",
    event = "VeryLazy",
    init = function()
      vim.api.nvim_create_user_command("GitBrowse", function(args)
        local visual_mode = args.range == 0
        require("git.browse").open(visual_mode)
      end, { range = true })
    end,
    opts = {},
  },
  {
    "kevinhwang91/nvim-hlslens",
    version = "1.1.0",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "*",
        [[*<Cmd>lua require('hlslens').start()<CR>]],
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "#",
        [[#<Cmd>lua require('hlslens').start()<CR>]],
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "g*",
        [[g*<Cmd>lua require('hlslens').start()<CR>]],
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "g#",
        [[g#<Cmd>lua require('hlslens').start()<CR>]],
        mode = "n",
        noremap = true,
        silent = true,
      },
      {
        "<Leader>l",
        "<Cmd>noh<CR>",
        mode = "n",
        noremap = true,
        silent = true,
      },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    commit = "5b103ef0fd2e8b9b4be3878ed38d224522192c6c",
    dependencies = {
      "kevinhwang91/nvim-hlslens",
      "lewis6991/gitsigns.nvim",
    },
    event = "VeryLazy",
    config = function()
      require("scrollbar").setup()

      require("scrollbar.handlers.search").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "3.9.0",
    event = "VeryLazy",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      scope = {
        enabled = true,
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    commit = "a94fc68960665e54408fe37dcf573193c4ce82c9",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = {
          "branch",
          "diff",
        },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
            sections = { "error", "warn", "info", "hint" },
            symbols = { error = " ", warn = " ", info = " ", hint = "" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = {
          {
            "tabs",
            mode = 2,
            fmt = function(name, context)
              -- Show + if buffer is modified in tab
              local buflist = vim.fn.tabpagebuflist(context.tabnr)
              local winnr = vim.fn.tabpagewinnr(context.tabnr)
              local bufnr = buflist[winnr]
              local mod = vim.fn.getbufvar(bufnr, "&mod")

              return name .. (mod == 1 and " +" or "")
            end,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      winbar = {},
      inactive_winbar = {},
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "1.13.0",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.termguicolors = true
    end,
    opts = {},
    keys = {
      { "<leader>e", vim.cmd.NvimTreeToggle, mode = "n" },
    },
  },
  {
    "nvim-tree/nvim-web-devicons",
    commit = "19d6211c78169e78bab372b585b6fb17ad974e82",
  },
  {
    "windwp/nvim-autopairs",
    commit = "2647cce4cb64fb35c212146663384e05ae126bdf",
    event = "InsertEnter",
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    event = "VeryLazy",
    opts = {
      defaults = {
        file_ignore_patterns = {
          ".git/",
        },
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
            ["<Esc>"] = require("telescope.actions").close,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = { additional_args = { "--hidden" } },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
    keys = {
      { "<leader>ff", require("telescope.builtin").find_files, mode = "n" },
      { "<leader>fg", require("telescope.builtin").live_grep, mode = "n" },
      { "<leader>fb", require("telescope.builtin").buffers, mode = "n" },
      { "<leader>fh", require("telescope.builtin").help_tags, mode = "n" },
    },
  },
  {
    "nvim-lua/plenary.nvim",
    version = "0.1.4",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    commit = "1f08ed60cafc8f6168b72b80be2b2ea149813e55",
    build = "make",
  },
  {
    "kylechui/nvim-surround",
    version = "3.1.2",
    event = "VeryLazy",
    opts = {},
  },
  {
    "terrortylor/nvim-comment",
    commit = "e9ac16ab056695cad6461173693069ec070d2b23",
    event = "VeryLazy",
    main = "nvim_comment",
    opts = {},
  },
  {
    "zbirenbaum/copilot.lua",
    commit = "c1bb86abbed1a52a11ab3944ef00c8410520543d",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = false,
      },
      panel = {
        enabled = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    commit = "9c762dcd457d2ab99edb3f3433cea9865ded47ad",
    config = function()
      local formatters = {
        css = "null-ls",
        go = "null-ls",
        html = "null-ls",
        javascript = "null-ls",
        javascriptreact = "null-ls",
        json = "null-ls",
        jsonc = "null-ls",
        lua = "null-ls",
        less = "null-ls",
        markdown = "null-ls",
        rust = "rust_analyzer",
        sass = "null-ls",
        scss = "null-ls",
        sh = "null-ls",
        terraform = "terraformls",
        typescript = "null-ls",
        typescriptreact = "null-ls",
        vue = "null-ls",
        yaml = "null-ls",
        zsh = "null-ls",
      }

      local function format()
        vim.lsp.buf.format({
          async = false,
          filter = function(c)
            return c.name == formatters[vim.bo.filetype]
          end,
        })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_clients({ name = formatters[vim.bo.filetype] })[1]
          if client == nil then
            return
          end
          if client.supports_method("textDocument/formatting", args.buf) then
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
              buffer = args.buf,
              callback = format,
            })
          end
        end,
      })

      vim.api.nvim_create_user_command("Format", format, {})
    end,
  },
  {
    "williamboman/mason.nvim",
    commit = "e2f7f9044ec30067bc11800a9e266664b88cda22",
    -- build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    commit = "ba9c2f0b93deb48d0a99ae0e8d8dd36f7cc286d6",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        automatic_installation = true,
        -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        ensure_installed = {
          "bashls",
          "gopls",
          "lua_ls",
          "rust_analyzer",
          "terraformls",
          "ts_ls",
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
                  checkThirdParty = false,
                },
                telemetry = {
                  enable = false,
                },
              },
            }
          end

          if server_name == "yamlls" then
            opts.settings = {
              yaml = {
                customTags = {
                  -- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html
                  "!Base64",
                  "!Cidr",
                  "!And",
                  "!Equals",
                  "!If",
                  "!Not",
                  "!Or",
                  "!FindInMap",
                  "!GetAtt",
                  "!GetAZs",
                  "!ImportValue",
                  "!Join",
                  "!Select",
                  "!Split",
                  "!Sub",
                  "!Transform",
                  "!Ref",
                },
              },
            }
          end

          require("lspconfig")[server_name].setup(opts)
        end,
      })
    end,
  },
  {
    "folke/trouble.nvim",
    version = "3.7.1",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "glepnir/lspsaga.nvim",
    commit = "920b1253e1a26732e53fac78412f6da7f674671d",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LspAttach",
    opts = {},
    keys = {
      -- Code Action
      { "<Leader>ac", "<cmd>Lspsaga code_action<CR>", mode = { "n", "v" } },
      -- Callhierarchy
      { "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", mode = "n" },
      { "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", mode = "n" },
      -- Definition
      { "gd", "<cmd>Lspsaga goto_definition<CR>", mode = "n" },
      { "gy", "<cmd>Lspsaga goto_type_definition<CR>", mode = "n" },
      -- Diagnostic
      { "<Leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", mode = "n" },
      { "<Leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", mode = "n" },
      { "<Leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", mode = "n" },
      { "<Leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>", mode = "n" },
      { "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", mode = "n" },
      { "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", mode = "n" },
      {
        "[E",
        function()
          require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
        end,
        mode = "n",
      },
      {
        "]E",
        function()
          require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
        end,
        mode = "n",
      },
      -- Finder
      { "gh", "<cmd>Lspsaga finder<CR>", mode = "n" },
      { "gf", "<cmd>Lspsaga finder<CR>", mode = "n" },
      -- Float terminal
      { "<Leader>t", "<cmd>Lspsaga term_toggle<CR>", mode = { "n", "t" } },
      -- Hover
      { "K", "<cmd>Lspsaga hover_doc<CR>", mode = "n" },
      -- Outline
      { "<Leader>o", "<cmd>Lspsaga outline<CR>", mode = "n" },
      -- Rename
      { "<Leader>rn", "<cmd>Lspsaga rename<CR>", mode = "n" },
    },
  },
  {
    "j-hui/fidget.nvim",
    version = "1.6.1",
    event = "VeryLazy",
    opts = {},
  },
  {
    "nvimtools/none-ls.nvim",
    commit = "db2a48b79cfcdab8baa5d3f37f21c78b6705c62e",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-luacheck.nvim",
      "gbprod/none-ls-shellcheck.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      local eslint_condition = function(utils)
        return utils.root_has_file({
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
          ".eslintrc.js",
          ".eslintrc.cjs",
          ".eslintrc.yaml",
          ".eslintrc.yml",
          ".eslintrc.json",
        })
      end

      null_ls.setup({
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
        sources = {
          -- Code Actions
          require("none-ls.code_actions.eslint").with({
            condition = eslint_condition,
          }),
          require("none-ls-shellcheck.code_actions"),

          -- Diagnostics
          null_ls.builtins.diagnostics.actionlint,
          require("none-ls.diagnostics.eslint").with({
            condition = eslint_condition,
          }),
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.hadolint,
          require("none-ls-luacheck.diagnostics.luacheck"),
          null_ls.builtins.diagnostics.markdownlint,
          require("none-ls-shellcheck.diagnostics"),
          null_ls.builtins.diagnostics.stylelint.with({
            filetypes = { "scss", "less", "css", "sass", "vue" },
            condition = function(utils)
              return utils.root_has_file({
                "stylelint.config.js",
                ".stylelintrc.js",
                "stylelint.config.mjs",
                ".stylelintrc.mjs",
                "stylelint.config.cjs",
                ".stylelintrc.cjs",
                ".stylelintrc.json",
                ".stylelintrc.yml",
                ".stylelintrc.yaml",
                ".stylelintrc",
              })
            end,
          }),

          -- Formatting
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.shfmt.with({
            extra_args = { "--indent", "2", "--binary-next-line", "--case-indent" },
          }),
          null_ls.builtins.formatting.stylua,
        },
      })
    end,
  },
  {
    "nvimtools/none-ls-extras.nvim",
    commit = "924fe88a9983c7d90dbb31fc4e3129a583ea0a90",
  },
  {
    "gbprod/none-ls-luacheck.nvim",
    version = "0.0.1",
  },
  {
    "gbprod/none-ls-shellcheck.nvim",
    commit = "0f84461241e76e376a95fb7391deac82dc3efdbf",
  },
  {
    "hrsh7th/nvim-cmp",
    version = "0.0.2",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "onsails/lspkind.nvim",
      "koyashiro/cmp-uuid",
      "zbirenbaum/copilot.lua",
      "zbirenbaum/copilot-cmp",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "uuid" },
          { name = "copilot" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = require("lspkind").cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = { Copilot = "" },
          }),
        },
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      require("copilot_cmp").setup()
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    commit = "a8912b88ce488f411177fc8aed358b04dc246d7b",
  },
  {
    "hrsh7th/cmp-buffer",
    commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
  },
  {
    "hrsh7th/cmp-path",
    commit = "c6635aae33a50d6010bf1aa756ac2398a2d54c32",
  },
  {
    "hrsh7th/cmp-cmdline",
    commit = "d126061b624e0af6c3a556428712dd4d4194ec6d",
  },
  {
    "hrsh7th/cmp-vsnip",
    commit = "989a8a73c44e926199bfd05fa7a516d51f2d2752",
  },
  {
    "hrsh7th/vim-vsnip",
    commit = "0a4b8419e44f47c57eec4c90df17567ad4b1b36e",
  },
  {
    "onsails/lspkind.nvim",
    commit = "d79a1c3299ad0ef94e255d045bed9fa26025dab6",
  },
  {
    "koyashiro/cmp-uuid",
    version = "0.2.0",
  },
  {
    "zbirenbaum/copilot-cmp",
    commit = "15fc12af3d0109fa76b60b5cffa1373697e261d1",
  },
}
