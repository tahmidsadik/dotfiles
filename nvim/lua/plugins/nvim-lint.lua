return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufEnter", "BufNewFile" },
		opts = {
			events = { "BufEnter", "BufReadPost", "BufWritePost", "InsertLeave" },
			linters_by_ft = {
				fish = { "fish" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				svente = { "eslint_d" },
				python = { "pylint" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft

			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = function()
					lint.try_lint()
				end,
			})
		end,
		keys = {
			{
				"<leader>l",
				function()
					require("lint").try_lint()
				end,
				{ desc = "Trigger linting for current file" },
			},
		},
	},
}
