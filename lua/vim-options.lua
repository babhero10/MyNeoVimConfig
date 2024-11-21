-- Spaces and editor configurations.
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Navigate vim panes better
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")

-- Key mapping
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })

-- Auto run codes
vim.keymap.set("n", "<C-r>", function()
	local filetype = vim.bo.filetype
	local filepath = vim.fn.expand("%:p")

	-- Command to run the file in tmux
	local command = ""

	if filetype == "python" then
		command = "python3 " .. filepath
	elseif filetype == "java" then
		local classname = vim.fn.expand("%:t:r")
		command = "javac " .. filepath .. " && java " .. classname
	elseif filetype == "c" then
		local output = vim.fn.expand("%:r")
		command = "gcc " .. filepath .. " -o " .. output .. " && ./" .. output
	else
		print("Unsupported file type: " .. filetype)
		return
	end

	-- Get the current tmux session name
	local tmux_session = vim.fn.system("tmux display-message -p '#S'"):gsub("\n", "")

	-- Check if we have a tmux session
	if tmux_session == "" then
		print("No active tmux session found!")
		return
	end

	-- Create a new window in the current tmux session and run the command
	local tmux_command = string.format("tmux new-window -t %s -n 'run_code' '%s'", tmux_session, command)
	vim.fn.system(tmux_command)

	print("Running code in tmux...")
end, { desc = "Run current file in tmux" })
