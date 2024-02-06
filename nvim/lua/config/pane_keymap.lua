return {
	setup = function(opts)
		-- swiching between panes
		vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the pane on the left" })
		vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the pane below" })
		vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the pane above" })
		vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the pane on the right" })

		-- resizing windows
		vim.keymap.set(
			"n",
			"<M-right>",
			"<cmd>:vertical res -2<cr>",
			{ desc = "Expand the current pane to to the right" }
		)
		vim.keymap.set("n", "<M-left>", "<cmd>:vertical res +2<cr>", { desc = "Expand the current pane to the left" })
		vim.keymap.set("n", "<M-up>", "<cmd>:res -2<cr>", { desc = "Expand the current pane to the top " })
		vim.keymap.set("n", "<M-down>", "<cmd>:res +2<cr>", { desc = "Expand the current pane to the bottom" })

		-- Center current pane
		vim.keymap.set("n", "<leader>h", "<C-w>H", { desc = "Center the current pane horizontally" })
		vim.keymap.set("n", "<leader>k", "<C-w>K", { desc = "Center the current pane vertically" })

		-- split a vertical pane with leader v
		vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Split a vertical pane" })
	end,
}
