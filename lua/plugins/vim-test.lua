return {
  "vim-test/vim-test",
  dependencies = {
    "preservim/vimux",
  },
  config = function()
    -- Keybindings for running tests
    vim.keymap.set("n", "<leader>t", ":TestNearest<CR>", { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>T", ":TestFile<CR>", { desc = "Run all tests in current file" })
    vim.keymap.set("n", "<leader>a", ":TestSuite<CR>", { desc = "Run entire test suite" })
    vim.keymap.set("n", "<leader>l", ":TestLast<CR>", { desc = "Run last test" })
    vim.keymap.set("n", "<leader>g", ":TestVisit<CR>", { desc = "Go to last test" })

    -- Set the testing strategy to vimux
    vim.cmd("let test#strategy = 'vimux'")

    -- Configure test runners for supported languages
    vim.cmd([[
      let test#python#runner = 'pytest'   " Set Python test framework
      let test#java#runner = 'gradle'    " Set Java test framework
      let test#c#runner = 'ctest'        " Set C test framework
    ]])

    -- Optional: If your Java projects use Maven instead of Gradle
    -- vim.cmd("let test#java#runner = 'maven'")
  end,
}
