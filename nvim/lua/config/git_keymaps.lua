-- keymaps for git

return {
	setup = function(opts)
		-- swiching between panes
		vim.keymap.set("n", "<leader>gst", ":Git<CR>", {})
		vim.keymap.set("n", "<leader>gd", ":Gvdiff<CR>", {})
		vim.keymap.set("n", "<leader>grm", ":Gdelete<CR>", {})
		vim.keymap.set("n", "<leader>gmv", ":Gmove<CR>", {})
		vim.keymap.set("n", "<leader>gco", ":Gread<CR>", {})
		vim.keymap.set("n", "<leader>ga", ":Gwrite<CR>", {})
		vim.keymap.set("n", "<leader>gc", ":Git<CR>", {})
	end,
}
