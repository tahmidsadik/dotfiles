return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
        -- add a keymap to browse plugin files
        -- stylua: ignore
        {
          "<leader>fp",
          function() require("telescope.builtin").find_files({ cwd = "~/.config/nvim" }) end,
          desc = "Find Plugin File",
        },
			{
				"<C-p>",
				function()
					require("telescope.builtin").git_files({
						hidden = true,
					})
				end,
				desc = "Find files",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<C-f>",
				"<cmd>Telescope live_grep<CR>",
				desc = "Search text",
			},
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffers",
			},
		},
		-- change some options
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "top" },
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},

	-- add telescope-fzf-native
	{
		"telescope.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
				require("telescope").setup({
					pickers = {
						colorscheme = {
							enable_preview = true,
						},
					},
				})
			end,
		},
	},
}
