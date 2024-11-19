return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Basic setup for neo-tree
      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visiable = true,
            hide_dotfiles = false,
          },
        },
      })

      -- Keybindings for Neo-tree
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Example keybindings
      map("n", "<leader>e", ":Neotree toggle<CR>", opts) -- Toggle Neo-tree
      map("n", "<leader>o", ":Neotree focus<CR>", opts)  -- Focus Neo-tree
    end,
  },
}

