return {
	setup = function(opts)
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<C-\\>", function()
			api.tree.toggle()
		end, { desc = "Open File Tree" })

		vim.keymap.set("n", "<leader>fi", function()
			api.tree.find_file()
		end, { desc = "Open File Tree" })
	end,
}
