return {
	setup = function(opts)
		-- swiching between panes
		vim.keymap.set("n", "<C-h>", "<C-w>h", {})
		vim.keymap.set("n", "<C-j>", "<C-w>j", {})
		vim.keymap.set("n", "<C-k>", "<C-w>k", {})
		vim.keymap.set("n", "<C-l>", "<C-w>l", {})

		-- resizing windows
		vim.keymap.set("n", "<M-right>", ":vertical res -2<CR>", {})
		vim.keymap.set("n", "<M-left>", ":vertical res +2<CR>", {})
		vim.keymap.set("n", "<M-up>", ":res -2<CR>", {})
		vim.keymap.set("n", "<M-down>", ":res +2<CR>", {})

		-- Center current pane
		vim.keymap.set("n", "<leader>h", "<C-w>H", {})
		vim.keymap.set("n", "<leader>K", "<C-w>H", {})

		-- split a vertical pane with leader v
		vim.keymap.set("n", "<leader>v", "<C-w>v", {})
	end,
}
