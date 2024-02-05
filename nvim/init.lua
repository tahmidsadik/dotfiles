vim.g.mapleader = ","
-- add static node js path so it works well with volta
require("config.neovide").setup({})
require("config.projectrunner").setup({})
require("config.pane_keymap").setup({})

vim.opt.termguicolors = true

-- vim.opt.wildmenu = true
-- vim.opt.wildmode = "list:longest"
-- vim.opt.showmatch = true
vim.opt.formatoptions = "qrn1"

local home_dir = os.getenv("HOME")
local node_bin_path = "/.volta/tools/image/node/20.5.1/bin"
vim.cmd("let $PATH = '" .. home_dir .. node_bin_path .. ":' . $PATH")

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

require("lazy").setup("plugins")

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

vim.opt.background = "light"
vim.opt.foldenable = true

--- keybinding for terminal
vim.keymap.set("n", "<S-h>", ":bprevious<cr>", {})
vim.keymap.set("n", "<S-l>", ":bnext<cr>", {})
