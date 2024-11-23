return {
  {
     'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
          local builtin = require('telescope.builtin')

          -- Key mappings for Telescope commands
          vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
          vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

          -- Additional key mapping for opening files and syncing with NeoTree
          vim.keymap.set('n', '<leader>fe', function()
              builtin.find_files({
                  attach_mappings = function(prompt_bufnr, map)
                      local actions = require('telescope.actions')
                      map('i', '<CR>', function()
                          local selection = require('telescope.actions.state').get_selected_entry()
                          actions.close(prompt_bufnr)
                          -- Open the file and sync with NeoTree
                          vim.cmd("NeoTreeFocusToggle")
                          vim.cmd("e " .. selection.path)
                          vim.cmd("NeoTreeReveal")
                      end)
                      return true
                  end
              })
          end, { desc = 'Telescope find files with NeoTree sync' })
      end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
        -- This is your opts table
        require("telescope").setup {
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
              -- even more opts
            }

            -- pseudo code / specification for writing custom displays, like the one
            -- for "codeactions"
            -- specific_opts = {
            --   [kind] = {
            --     make_indexed = function(items) -> indexed_items, width,
            --     make_displayer = function(widths) -> displayer
            --     make_display = function(displayer) -> function(e)
            --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
            -- }
          }
        }
      }
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end
  }

}
