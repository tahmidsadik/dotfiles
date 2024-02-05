return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufEnter", "BufNewFile" },
		opts = {
			events = { "BufEnter", "BufWritePost" },
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
		config = function()
			local lint = require("lint")

			local lint_augroup = vim.api.nvim_create_augroup("nvim-lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = lint_augroup,
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
