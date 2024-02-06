-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<Space>q", vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<Space>wl", function() end, bufopts)
	vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<Space>rn", function()
		vim.lsp.buf.rename()
	end, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<Space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)

	vim.keymap.set("n", "<leader>rr", "getFileName")
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }

		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<Space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<Space>wl", function() end, opts)
		vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<Space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
		vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, opts)
	end,
})

-- trouble setup

require("trouble").setup({})

-- keybinds
--
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

-- null-ls setup
-- local null_ls = require("null-ls")
--
-- null_ls.setup({
-- 	sources = {
-- 		null_ls.builtins.formatting.stylua,
-- 		null_ls.builtins.diagnostics.eslint,
-- 		null_ls.builtins.completion.spell,
-- 	},
-- })

-- Eslint setup
-- local eslint = require("eslint")
--
-- eslint.setup({
--   bin = 'eslint', -- or `eslint_d`
--   code_actions = {
--     enable = true,
--     apply_on_save = {
--       enable = true,
--       types = { "directive", "problem", "suggestion", "layout" },
--     },
--     disable_rule_comment = {
--       enable = true,
--       location = "separate_line", -- or `same_line`
--     },
--   },
--   diagnostics = {
--     enable = true,
--     report_unused_disable_directives = false,
--     run_on = "type", -- or `save`
--   },
-- })
--
-- local prettier = require("prettier")
--
-- prettier.setup({
--   bin = 'prettier', -- or `'prettierd'` (v0.22+)
--   filetypes = {
--     "css",
--     "graphql",
--     "html",
--     "javascript",
--     "javascriptreact",
--     "json",
--     "less",
--     "markdown",
--     "scss",
--     "typescript",
--     "typescriptreact",
--     "yaml",
--   },
-- })

-- require('nvim-lightbulb').setup({
--     -- LSP client names to ignore
--     -- Example: {"sumneko_lua", "null-ls"}
--     ignore = {},
--     sign = {
--         enabled = true,
--         -- Priority of the gutter sign
--         priority = 10,
--     },
--     float = {
--         enabled = false,
--         -- Text to show in the popup float
--         text = "💡",
--         -- Available keys for window options:
--         -- - height     of floating window
--         -- - width      of floating window
--         -- - wrap_at    character to wrap at for computing height
--         -- - max_width  maximal width of floating window
--         -- - max_height maximal height of floating window
--         -- - pad_left   number of columns to pad contents at left
--         -- - pad_right  number of columns to pad contents at right
--         -- - pad_top    number of lines to pad contents at top
--         -- - pad_bottom number of lines to pad contents at bottom
--         -- - offset_x   x-axis offset of the floating window
--         -- - offset_y   y-axis offset of the floating window
--         -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
--         -- - winblend   transparency of the window (0-100)
--         win_opts = {},
--     },
--     virtual_text = {
--         enabled = false,
--         -- Text to show at virtual text
--         text = "💡",
--         -- highlight mode to use for virtual text (replace, combine, blend), see :help nvim_buf_set_extmark() for reference
--         hl_mode = "replace",
--     },
--     status_text = {
--         enabled = false,
--         -- Text to provide when code actions are available
--         text = "💡",
--         -- Text to provide when no actions are available
--         text_unavailable = ""
--     },
--     autocmd = {
--         enabled = true,
--         -- see :help autocmd-pattern
--         pattern = {"*"},
--         -- see :help autocmd-events
--         events = {"CursorHold", "CursorHoldI"}
--     }
-- })
