return {
	setup = function(opts)
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<C-\\>", function()
			api.tree.toggle()
		end, {})
	end,
}
