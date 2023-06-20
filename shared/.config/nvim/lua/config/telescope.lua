return function()
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
end
