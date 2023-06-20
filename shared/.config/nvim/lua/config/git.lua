return function()
  require("git").setup()

  vim.api.nvim_create_user_command("GitBrowse", function(args)
    local visual_mode = args.range == 0
    require("git.browse").open(visual_mode)
  end, { range = true })
end
