-- Function to send a command to a new tmux pane
local function run_in_tmux(command)
  -- Log the command to ensure it's correct
  print("Running tmux command: ", command)
  local tmux_command = string.format('tmux split-window -v "%s; bash -i"', command)  -- Keep tmux pane open
  vim.fn.system(tmux_command)  -- Run the tmux command
end

-- Command to run the current file
vim.api.nvim_create_user_command("RunFile", function()
  local filedir = vim.fn.expand("%:p:h") -- Directory of the current file
  local filename = vim.fn.expand("%:t") -- Filename with extension
  local filetype = vim.bo.filetype -- Get the filetype
  local classname = vim.fn.expand("%:t:r") -- Filename without extension (class name)

  -- Commands for specific file types
  local commands = {
    python = string.format("cd '%s' && ~/env/bin/python '%s'", filedir, filename),
    lua = string.format("cd '%s' && lua '%s'", filedir, filename),
    bash = string.format("cd '%s' && bash '%s'", filedir, filename),
    java = string.format("cd '%s' && javac *.java && java '%s'", filedir, classname),
    c = string.format("cd '%s' && gcc '%s' -o output && ./output", filedir, filename),
  }

  -- Default message for unsupported filetypes
  local command = commands[filetype] or string.format("echo 'Unsupported filetype: %s'", filetype)

  -- Run the command in a new tmux pane below and keep it open
  vim.fn.system(string.format("tmux split-window -v 'bash -ic \"%s; echo; echo Code execution finished. Press any key to exit.; read -n 1\"'", command))
end, { nargs = 0 })

-- Command to run a `just` task
vim.api.nvim_create_user_command('RunJustTask', function()
  -- Ask the user for a `just` task to run
  local task = vim.fn.input('Enter just task: ')
  if task and #task > 0 then
    local command = 'just ' .. task
    run_in_tmux(command)
  else
    print("No task provided.")
  end
end, { desc = "Run just task in a new tmux pane" })
