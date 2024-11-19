require("vim-options")
require("config.lazy")

-- Alpha nvim setup (conditional loading)
local alpha = require'alpha'
local startify = require'alpha.themes.startify'

-- Check if the directory or file is passed as an argument
if #vim.fn.argv() == 0 or vim.fn.isdirectory(vim.fn.argv()[1]) == 1 then
  -- Show alpha if no file or folder is passed
  alpha.setup(startify.config)
else
  -- Otherwise, proceed without Alpha (handle folder or file opening)
  -- For example, initialize your folder plugin (like nvim-tree or telescope)
  -- require'nvim-tree'.setup()
end
