return {
  -- Mason setup
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },

  -- Mason LSPConfig setup
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = { "lua_ls", "clangd", "pylsp", "jdtls" }  -- Corrected clang to clangd
      })
    end
  },

  -- nvim-lspconfig setup
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require('lspconfig')

      -- Setup lua_ls (Lua Language Server)
      lspconfig.lua_ls.setup {
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}  -- Add vim to the list of recognized globals
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),  -- Include Neovim runtime files
            }
          }
        }
      }

      -- Setup clangd (C/C++ Language Server)
      lspconfig.clangd.setup {}

      -- Setup pylsp (Python Language Server)
      lspconfig.pylsp.setup {}

      -- Setup jdtls (Java Language Server)
      lspconfig.jdtls.setup {}

      -- Setup keybindings for LSP directly
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)  -- Go to declaration
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)    -- Go to definition
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)           -- Hover
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)  -- Go to implementation
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help) -- Signature help
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)  -- Rename
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action) -- Code action
      vim.keymap.set('n', 'gr', vim.lsp.buf.references)      -- Go to references
      vim.keymap.set('n', '<leader>f', vim.lsp.buf.format) -- Format buffer
    end
  }
}
