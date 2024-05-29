return {
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = {
          enable = true,
        },
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
        auto_install = true,
      })
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "dinhhuy258/git.nvim",
    event = "InsertEnter",
    config = function()
      require("git").setup()

      vim.api.nvim_create_user_command("GitBrowse", function(args)
        local visual_mode = args.range == 0
        require("git.browse").open(visual_mode)
      end, { range = true })
    end,
  },
  {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
      require("hlslens").setup()

      vim.keymap.set(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
      )
      vim.keymap.set(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
      )
      vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
      vim.keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })

      vim.keymap.set("n", "<Leader>l", "<Cmd>noh<CR>", { noremap = true, silent = true })
    end,
  },
  {
    "petertriho/nvim-scrollbar",
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
    event = "VeryLazy",
    config = function()
      require("ibl").setup({
        scope = { enabled = true },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
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
      })
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      vim.opt.termguicolors = true

      require("nvim-tree").setup()

      vim.api.nvim_create_user_command("Ex", function()
        vim.cmd.NvimTreeToggle()
      end, {})

      vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            ".git/",
          },
          mappings = {
            i = {
              ["<C-h>"] = "which_key",
              ["<Esc>"] = actions.close,
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
      })
      telescope.load_extension("fzf")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", function()
        builtin.find_files()
      end)
      vim.keymap.set("n", "<leader>fg", function()
        builtin.live_grep()
      end)
      vim.keymap.set("n", "<leader>fb", function()
        builtin.buffers()
      end)
      vim.keymap.set("n", "<leader>fh", function()
        builtin.help_tags()
      end)
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "terrortylor/nvim-comment",
    event = "VeryLazy",
    config = function()
      require("nvim_comment").setup()
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    build = ":MasonUpdate",
    config = function()
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
          "terraformls",
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()

      vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
      vim.keymap.set(
        "n",
        "<leader>xw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>xd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        { silent = true, noremap = true }
      )
      vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
      vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
      vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LspAttach",
    config = function()
      require("lspsaga").setup()

      -- LSP finder
      vim.keymap.set("n", "gh", "<cmd>Lspsaga finder<CR>")
      vim.keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>")

      -- Code action
      vim.keymap.set({ "n", "v" }, "<Leader>ac", "<cmd>Lspsaga code_action<CR>")
      vim.keymap.set({ "n", "v" }, "<Leader>ca", "<cmd>Lspsaga code_action<CR>")

      -- Rename
      vim.keymap.set("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>")

      -- Go to definition
      vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

      -- Go to type definition
      vim.keymap.set("n", "gy", "<cmd>Lspsaga goto_type_definition<CR>")

      -- Show line diagnostics
      vim.keymap.set("n", "<Leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

      -- Show buffer diagnostics
      vim.keymap.set("n", "<Leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

      -- Show workspace diagnostics
      vim.keymap.set("n", "<Leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

      -- Show cursor diagnostics
      vim.keymap.set("n", "<Leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

      -- Diagnostic jump
      vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

      -- Diagnostic jump with filters such as only jumping to an error
      vim.keymap.set("n", "[E", function()
        require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
      end)
      vim.keymap.set("n", "]E", function()
        require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
      end)

      -- Toggle outline
      vim.keymap.set("n", "<Leader>o", "<cmd>Lspsaga outline<CR>")

      -- Hover Doc
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")

      -- Call hierarchy
      vim.keymap.set("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
      vim.keymap.set("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

      -- Floating terminal
      vim.keymap.set({ "n", "t" }, "<Leader>t", "<cmd>Lspsaga term_toggle<CR>")
    end,
  },
  {
    "j-hui/fidget.nvim",
    event = "VeryLazy",
    config = function()
      require("fidget").setup()
    end,
    tag = "legacy",
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
      "gbprod/none-ls-luacheck.nvim",
      "gbprod/none-ls-shellcheck.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      vim.api.nvim_create_user_command("Format", function()
        vim.lsp.buf.format({
          async = false,
          filter = function(c)
            return c.name == "null-ls"
          end,
        })
      end, {})

      null_ls.setup({
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
        sources = {
          -- Code Actions
          require("none-ls.code_actions.eslint"),
          require("none-ls-shellcheck.code_actions"),

          -- Diagnostics
          null_ls.builtins.diagnostics.actionlint,
          require("none-ls.diagnostics.eslint"),
          null_ls.builtins.diagnostics.golangci_lint,
          null_ls.builtins.diagnostics.hadolint,
          require("none-ls-luacheck.diagnostics.luacheck"),
          null_ls.builtins.diagnostics.markdownlint,
          require("none-ls-shellcheck.diagnostics"),
          null_ls.builtins.diagnostics.stylelint.with({
            filetypes = { "scss", "less", "scss", "sass", "vue" },
          }),

          -- Formatting
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.prettierd,
          require("none-ls.formatting.rustfmt"),
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.terraform_fmt,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({
                  async = false,
                  filter = function(c)
                    return c.name == "null-ls"
                  end,
                })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/vim-vsnip",
      "onsails/lspkind.nvim",
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
}
