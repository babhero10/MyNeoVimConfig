return {
  "christoomey/vim-tmux-navigator",
  vim.keymap.set("n", "C-h", ":TmuxNavigatLeft<CR>"),
  vim.keymap.set("n", "C-j", ":TmuxNavigatDown<CR>"),
  vim.keymap.set("n", "C-k", ":TmuxNavigatUp<CR>"),
  vim.keymap.set("n", "C-l", ":TmuxNavigatRight<CR>"),
}

