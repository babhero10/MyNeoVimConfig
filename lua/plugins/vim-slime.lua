return {
  "jpalardy/vim-slime",
  config = function()
    vim.g.slime_target = "tmux" -- Set target as tmux
    vim.g.slime_paste_file = "/tmp/slime" -- Optional paste method
    vim.keymap.set("n", "<leader>r", "<Plug>SlimeSend", { desc = "Send to Tmux" })
    vim.keymap.set("v", "<leader>r", "<Plug>SlimeRegionSend", { desc = "Send region to Tmux" })
  end,
}
