return {
	{
		"LazyVim/LazyVim",
		{
			"nvim-lualine/lualine.nvim",
			event = "VeryLazy",
			opts = require("config.statusline").setup,
		},

		{
			"dstein64/vim-startuptime",
			-- lazy-load on a command
			cmd = "StartupTime",
			-- init is called during startup. Configuration for vim plugins typically should be set in an init function
			init = function()
				vim.g.startuptime_tries = 10
			end,
		},

		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			init = function()
				vim.o.timeoutlen = 500
				vim.o.timeout = true
			end,
			opts = {},
		},
		{ "folke/neoconf.nvim", cmd = "Neoconf" },
		{ "folke/neodev.nvim" },
		--- luasnip
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},

		{ "mhinz/vim-startify", lazy = false },
		{ "dhruvasagar/vim-table-mode", event = "VeryLazy" },
		"powerman/vim-plugin-AnsiEsc",
		"ziglang/zig.vim",
		"editorconfig/editorconfig-vim",
		"machakann/vim-highlightedyank",
		"iamcco/markdown-preview.nvim",
		"tommcdo/vim-lion",
		{
			"xolox/vim-notes",
			dependencies = {
				"xolox/vim-misc",
			},
		},
		"mattn/emmet-vim",
		"cespare/vim-toml",
		"norcalli/nvim-colorizer.lua",
		--- lsp
		{
			"neovim/nvim-lspconfig",
			init = function()
				local keys = require("lazyvim.plugins.lsp.keymaps").get()
				vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename, { desc = "Rename refactor a symbol with LSP" })
				vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action, { desc = "Take code actions via lsp" })
				vim.keymap.set("n", "<leader>oa", "<cmd>TypescriptOrganizeImports<CR>", { desc = "Organize Imports" })
			end,
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{ "folke/neoconf.nvim", cmd = "Neoconf" },
				{ "folke/neodev.nvim" },
				"mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"hrsh7th/cmp-nvim-lsp",
			},
			---@class PluginLspOpts
			opts = {
				-- options for vim.diagnostic.config()
				diagnostics = {
					underline = true,
					update_in_insert = false,
					virtual_text = {
						spacing = 4,
						source = "if_many",
						prefix = "●",
						-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
						-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
						-- prefix = "icons",
					},
					severity_sort = true,
				},
				-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the inlay hints.
				inlay_hints = {
					enabled = false,
				},
				-- add any global capabilities here
				capabilities = {},
				-- Automatically format on save
				autoformat = false,
				-- Enable this to show formatters used in a notification
				-- Useful for debugging formatter issues
				format_notify = false,
				-- options for vim.lsp.buf.format
				-- `bufnr` and `filter` is handled by the LazyVim formatter,
				-- but can be also overridden when specified
				format = {
					formatting_options = nil,
					timeout_ms = nil,
				},
				-- LSP Server Settings
				---@type lspconfig.options
				servers = {
					jsonls = {},
					lua_ls = {
						-- mason = false, -- set to false if you don't want this server to be installed with mason
						-- Use this to add any additional keymaps
						-- for specific lsp servers
						---@type LazyKeys[]
						-- keys = {},
						settings = {
							Lua = {
								workspace = {
									checkThirdParty = false,
								},
								completion = {
									callSnippet = "Replace",
								},
								diagnostics = {
									globals = {
										"vim",
									},
								},
							},
						},
					},
				},
				-- you can do any additional lsp server setup here
				-- return true if you don't want this server to be setup with lspconfig
				---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
				setup = {
					-- example to setup with typescript.nvim
					-- tsserver = function(_, opts)
					-- 	require("typescript").setup({
					-- 		server = opts,
					-- 		on_attach = function(client)
					-- 			client.resolved_capabilities.document_formatting = false
					-- 		end,
					-- 	})
					-- 	return true
					-- end,
					-- Specify * to use this function as a fallback for any server
					-- ["*"] = function(server, opts) end,
				},
			},
			---@param opts PluginLspOpts
			config = function(_, opts)
				local Util = require("lazyvim.util")
				local neodev = require("neodev")
				neodev.setup({})

				if Util.has("neoconf.nvim") then
					local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
					require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
				end
				-- setup autoformat
				-- require("lazyvim.plugins.lsp.format").setup(opts)
				-- setup formatting and keymaps
				Util.lsp.on_attach(function(client, buffer)
					require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
				end)

				local register_capability = vim.lsp.handlers["client/registerCapability"]

				vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
					local ret = register_capability(err, res, ctx)
					local client_id = ctx.client_id
					---@type lsp.Client
					local client = vim.lsp.get_client_by_id(client_id)
					local buffer = vim.api.nvim_get_current_buf()
					require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
					return ret
				end

				-- diagnostics
				for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
					name = "DiagnosticSign" .. name
					vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
				end

				local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

				if opts.inlay_hints.enabled and inlay_hint then
					Util.lsp.on_attach(function(client, buffer)
						if client.server_capabilities.inlayHintProvider then
							inlay_hint(buffer, true)
						end
					end)
				end

				if
					type(opts.diagnostics.virtual_text) == "table"
					and opts.diagnostics.virtual_text.prefix == "icons"
				then
					opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
						or function(diagnostic)
							local icons = require("lazyvim.config").icons.diagnostics
							for d, icon in pairs(icons) do
								if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
									return icon
								end
							end
						end
				end

				vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

				local servers = opts.servers
				local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
				local capabilities = vim.tbl_deep_extend(
					"force",
					{},
					vim.lsp.protocol.make_client_capabilities(),
					has_cmp and cmp_nvim_lsp.default_capabilities() or {},
					opts.capabilities or {}
				)

				local function setup(server)
					local server_opts = vim.tbl_deep_extend("force", {
						capabilities = vim.deepcopy(capabilities),
					}, servers[server] or {})

					if opts.setup[server] then
						if opts.setup[server](server, server_opts) then
							return
						end
					elseif opts.setup["*"] then
						if opts.setup["*"](server, server_opts) then
							return
						end
					end
					require("lspconfig")[server].setup(server_opts)
					require("lspconfig").bashls.setup({})
				end

				-- get all the servers that are available thourgh mason-lspconfig
				local have_mason, mlsp = pcall(require, "mason-lspconfig")
				local all_mslp_servers = {}
				if have_mason then
					all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
				end

				local ensure_installed = {} ---@type string[]
				for server, server_opts in pairs(servers) do
					if server_opts then
						server_opts = server_opts == true and {} or server_opts
						-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
						if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
							setup(server)
						else
							ensure_installed[#ensure_installed + 1] = server
						end
					end
				end

				if have_mason then
					mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
				end

				if Util.lsp.get_config("denols") and Util.lsp.get_config("tsserver") then
					local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
					Util.lsp.disable("tsserver", is_deno)
					Util.lsp.disable("denols", function(root_dir)
						return not is_deno(root_dir)
					end)
				end
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" },
		{
			"mg979/vim-visual-multi",
			branch = "master",
		},
		{
			"williamboman/mason.nvim",
			cmd = "Mason",
			keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
			build = ":MasonUpdate",
			opts = {
				ensure_installed = {
					-- rust
					"rust-analyzer",
					--- golang
					"gopls",
					--- js/ts
					"typescript-language-server",
					"prettier",
					"eslint_d",
					--- lua
					"stylua",
					"lua-language-server",
					--- shell
					"shfmt",
					"bash-language-server",
					--- zig
					"zls",
				},
			},

			config = function(_, opts)
				require("mason").setup(opts)
				local mr = require("mason-registry")
				local function ensure_installed()
					for _, tool in ipairs(opts.ensure_installed) do
						local p = mr.get_package(tool)
						if not p:is_installed() then
							p:install()
						end
					end
				end
				if mr.refresh then
					mr.refresh(ensure_installed)
				else
					ensure_installed()
				end
			end,
		},
		--- autocompletion
		{
			"hrsh7th/nvim-cmp",
			-- load cmp on InsertEnter
			event = "InsertEnter",
			-- these dependencies will only be loaded when cmp loads
			-- dependencies are always lazy-loaded unless specified otherwise
			dependencies = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-cmdline",
				"saadparwaiz1/cmp_luasnip",
			},
			opts = function()
				vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
				local luasnip = require("luasnip")
				local cmp = require("cmp")
				local defaults = require("cmp.config.default")()

				local has_words_before = function()
					unpack = unpack or table.unpack
					local line, col = unpack(vim.api.nvim_win_get_cursor(0))
					return col ~= 0
						and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
				end

				return {
					completion = {
						completeopt = "menu,menuone,noinsert",
					},
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
					sources = cmp.config.sources({
						{
							name = "nvim_lsp",
							entry_filter = function(entry, ctx)
								return cmp.lsp.CompletionItemKind.Text ~= entry:get_kind()
							end,
						},
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "path" },
						-- { name = "copilot", group_index = 2 },
					}),
					-- experimental = {
					-- 	ghost_text = {
					-- 		hl_group = "CmpGhostText",
					-- 	},
					-- },
					sorting = defaults.sorting,
					mapping = cmp.mapping.preset.insert({
						["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
						["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
						["<Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							elseif has_words_before() then
								cmp.complete()
							else
								fallback()
							end
						end, { "i", "s" }),
						["<S-Tab>"] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),
				}
			end,
		},
		{
			"folke/trouble.nvim",
			opts = function()
				require("config.trouble_keymap").setup()
			end,
		},
		{ "nvim-lua/plenary.nvim" },
		-- prettier
		{
			"MunifTanjim/prettier.nvim",
			cond = false,
		},
		{ "cohama/lexima.vim" },
		{ "https://github.com/tpope/vim-surround.git" },
		{ "diepm/vim-rest-console" },

		--- mini.nvim
		{
			"echasnovski/mini.nvim",
			config = function(self, opts)
				require("mini.comment").setup()
				require("mini.cursorword").setup()
				require("mini.align").setup()
				require("mini.pairs").setup()
				require("mini.indentscope").setup()
			end,
		},

		{
			"https://tpope.io/vim/fugitive.git",
			config = function()
				require("config.git_keymaps").setup({})
			end,
		},
		{
			"lewis6991/gitsigns.nvim",
			event = { "BufReadPre", "BufNewFile" },
			opts = {
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					delete = { text = "" },
					topdelete = { text = "" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				on_attach = function(buffer)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, desc)
						vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
					end

          -- stylua: ignore start
          map("n", "]h", gs.next_hunk, "Next Hunk")
          map("n", "[h", gs.prev_hunk, "Prev Hunk")
          map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
          map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
          map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
          map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
          map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
          map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
          map("n", "<leader>ghd", gs.diffthis, "Diff This")
          map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
				end,
			},
		},
		--- ui
		{
			"rcarriga/nvim-notify",
			keys = {
				{
					"<leader>un",
					function()
						require("notify").dismiss({ silent = true, pending = true })
					end,
					desc = "Dismiss all Notifications",
				},
			},
			opts = {
				timeout = 3000,
				max_height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.75)
				end,
			},
			init = function()
				-- when noice is not enabled, install notify on VeryLazy
				local Util = require("lazyvim.util")
				if not Util.has("noice.nvim") then
					Util.on_very_lazy(function()
						vim.notify = require("notify")
					end)
				end
			end,
		},
		{
			"folke/noice.nvim",
			dependencies = {
				"muniftanjim/nui.nvim",
			},
			opts = {
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true,
					},
				},
				routes = {
					{
						filter = {
							event = "msg_show",
							any = {
								{ find = "%d+L, %d+B" },
								{ find = "; after #%d+" },
								{ find = "; before #%d+" },
							},
						},
						view = "mini",
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = true,
				},
			},
		},
		{
			"mg979/vim-visual-multi",
			event = "InsertEnter",
		},
		{
			"nathanaelkane/vim-indent-guides",
		},
	},
}
