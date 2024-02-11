return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cond = true,
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			require("nvim-tree").setup({
				filters = {
					git_ignored = false,
				},
			})
			require("config.sidebar_keymap").setup({})
		end,
	},
}
