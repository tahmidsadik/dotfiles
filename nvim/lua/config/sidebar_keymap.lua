return {
	setup = function(opts)
		vim.keymap.set("n", "<C-\\>", ":NvimTreeToggle<CR>", {})
	end,
}
