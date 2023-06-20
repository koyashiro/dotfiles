return function()
  require("git").setup()

  vim.api.nvim_create_user_command("GitBrowse", function()
    require("git.browse").open(false)
  end, {})
end
