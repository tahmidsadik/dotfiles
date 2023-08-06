local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	--- colorscheme
	{
		"iCyMind/NeoSolarized",
		lazy = false,  -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme NeoSolarized]])
		end,
	},
	"LazyVim/LazyVim",
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup()
		end,
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

	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	{ "folke/neodev.nvim" },
	--- luasnip
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},

	"mhinz/vim-startify",
	{ "dhruvasagar/vim-table-mode", cond = false },
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
	"https://github.com/github/copilot.vim",
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require('nvim-treesitter.configs').setup({
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false
				}
			})
		end
	},
	"nvim-treesitter/playground",
	"cespare/vim-toml",
	"norcalli/nvim-colorizer.lua",
	{ "sheerun/vim-polyglot",       cond = false },
	--- lsp
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			{ "folke/neodev.nvim",  opts = {} },
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
			autoformat = true,
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
				--   require("typescript").setup({ server = opts })
				--   return true
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
			require("lazyvim.plugins.lsp.format").setup(opts)
			-- setup formatting and keymaps
			Util.on_attach(function(client, buffer)
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
				Util.on_attach(function(client, buffer)
					if client.server_capabilities.inlayHintProvider then
						inlay_hint(buffer, true)
					end
				end)
			end

			if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
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
				require("lspconfig").bashls.setup {}
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

			if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
				local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
				Util.lsp_disable("tsserver", is_deno)
				Util.lsp_disable("denols", function(root_dir)
					return not is_deno(root_dir)
				end)
			end
		end,
	},
	{ "williamboman/mason-lspconfig.nvim" },
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
				--- lua
				"stylua",
				"lua-language-server",
				--- shell
				"shfmt",
				"bash-language-server"
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
					-- { name = "buffer" },
					{ name = "path" },
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
							cmp.select_next_item()
							-- cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
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
	{ "nvim-tree/nvim-tree.lua" },
	{ "nvim-tree/nvim-web-devicons",      lazy = true },
	{ "folke/trouble.nvim" },
	{ "nvim-lua/plenary.nvim" },
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("null-ls").setup({
				source = {
					require("null-ls").builtins.formatting.shfmt,
					require("null-ls").builtins.formatting.prettier,
				},
			})
		end,
	},
	{ "cohama/lexima.vim" },
	{ "https://github.com/tpope/vim-surround.git" },
	{ "diepm/vim-rest-console" },
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
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},
			{
				"<C-f>",
				"<cmd>Telescope live_grep<CR>",
				desc = "Search text",
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
			end,
		},
	},

	--- mini.nvim
	{ "echasnovski/mini.nvim",    version = false },

	--- terminal
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-t>]],
				direction = "vertical",
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.45
					end
				end,
			})
		end,
	},
	"matthewtodd/vim-twilight",
	"jnurmine/Zenburn",
	"vim-scripts/xoria256.vim",
	"nanotech/jellybeans.vim",
	"morhetz/gruvbox",
	"zeis/vim-kolor",
	"tomasr/molokai",
	"altercation/vim-colors-solarized",
	"nathanaelkane/vim-indent-guides",
	"ayu-theme/ayu-vim",
	"fneu/breezy",
	"dim13/smyck.vim",
	"joshdick/onedark.vim",
	"folke/tokyonight.nvim",
	"haishanh/night-owl.vim",
	"NLKNguyen/papercolor-theme",
	"skbolton/embark",
	{ "arcticicestudio/nord-vim", branch = "main" },
	"franbach/miramare",
	"srcery-colors/srcery-vim",
	"vimoxide/vim-cinnabar",
	"fenetikm/falcon",
	"sainnhe/forest-night",
	"sainnhe/gruvbox-material",
	"sainnhe/edge",
	"sainnhe/sonokai",
	"aonemd/quietlight.vim",
})

--- setup minit comment

require("mini.comment").setup()

--- keybinding for terminal

local run_project = function()
	local term_cmd = ''
	if vim.bo.filetype == 'rust' then
		print('running rust project')
		term_cmd = 'cargo run'
	elseif vim.bo.filetype == 'typescript' or vim.bo.filetype == 'javascript' then
		print('running typescript project')
		term_cmd = 'npm start'
	elseif vim.bo.filetype == 'typescript' or vim.bo.filetype == 'go' then
		print('running go project')
		term_cmd = 'make run'
	end
	if term_cmd ~= '' then
		print("Executing command")
		vim.cmd(string.format(":TermExec cmd='%s'", term_cmd))
	else
		print("No run config configured for filetype ", vim.bo.filetype)
	end
end


vim.keymap.set('n', '<leader>rr', run_project, {})
