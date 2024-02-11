return {
	setup = function()
		vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", {})
		vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", {})
	end,
}
