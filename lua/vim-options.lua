-- Spaces and editor configurations.
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Key mapping
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
