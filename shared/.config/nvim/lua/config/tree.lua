return function()
  vim.api.nvim_set_var("loaded_netrw", 1)
  vim.api.nvim_set_var("loaded_netrwPlugin", 1)

  require("nvim-tree").setup()

  vim.api.nvim_create_user_command("Ex", function()
    vim.cmd.NvimTreeToggle()
  end, {})

  vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
end
