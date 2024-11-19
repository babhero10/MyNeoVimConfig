return {

  'folke/todo-comments.nvim',
  requires = 'nvim-lua/plenary.nvim',
  config = function()
    require("todo-comments").setup {}
    vim.api.nvim_set_keymap('n', '<leader>nt', '<cmd>TodoNext<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>pt', '<cmd>TodoPrev<CR>', { noremap = true, silent = true })
  end
}
