local home_dir = os.getenv("HOME")
local node_bin_path = "/.volta/tools/image/node/20.5.1/bin"
-- add static node js path so it works well with volta
vim.cmd("let $PATH = '" .. home_dir .. node_bin_path .. ":' . $PATH")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- { import = "lazyvim.plugins.extras.lang.typescript" },
		-- { import = "lazyvim.plugins.extras.lang.json" },
		-- { import = "lazyvim.plugins.extras.ui.mini-animate" },
		{ import = "plugins" },
	},
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = { enabled = true }, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("config.neovide").setup({})
require("config.projectrunner").setup({})
require("config.pane_keymap").setup({})
require("config.buffer_keymap").setup()
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest"
vim.opt.showmatch = true
vim.opt.formatoptions = "qrn1"

vim.opt.termguicolors = true

-- basic indent and tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

-- set ruler
-- set line number and linespace

vim.opt.number = true
vim.opt.ruler = true
vim.opt.wrap = true
vim.opt.textwidth = 120
-- vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"

-- title of the file
vim.opt.title = true

vim.opt.background = "dark"
vim.opt.foldenable = true
