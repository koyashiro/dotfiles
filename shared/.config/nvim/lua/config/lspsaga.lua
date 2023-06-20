return function()
  require("lspsaga").setup()

  -- LSP finder
  vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
  vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>")

  -- Code action
  vim.keymap.set({ "n", "v" }, "<Leader>ac", "<cmd>Lspsaga code_action<CR>")
  vim.keymap.set({ "n", "v" }, "<Leader>ca", "<cmd>Lspsaga code_action<CR>")

  -- Rename
  vim.keymap.set("n", "<Leader>rn", "<cmd>Lspsaga rename<CR>")

  -- Go to definition
  vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")

  -- Go to type definition
  vim.keymap.set("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")

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
  vim.keymap.set({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
end
