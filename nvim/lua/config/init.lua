-- leader needs to be set before loading plugins
vim.g.mapleader = ","
-- add static node js path so it works well with volta
require("config.neovide").setup({})
require("config.projectrunner").setup({})
require("config.pane_keymap").setup({})

local home_dir = os.getenv("HOME")
local node_bin_path = "/Users/noshinshama/.volta/tools/image/node/25.2.1"
-- vim.cmd("let $PATH = '" .. home_dir .. node_bin_path .. ":' . $PATH")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  spec = {
    import = "plugins",
  },

  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "kanagawa" } },
  -- automatically check for plugin updates
  checker = { enabled = true },

  --- colorscheme
  --- ui
})

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

-- Add left margin to the editor
vim.opt.foldcolumn = "2"     -- Adds 2 columns of margin on the left
vim.opt.signcolumn = "yes" -- Always show sign column for consistent spacing
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

--- keybinding for terminal
vim.keymap.set("n", "<S-h>", ":bprevious<cr>", {})
vim.keymap.set("n", "<S-l>", ":bnext<cr>", {})
vim.keymap.set("n", "<leader>oa", function()
  vim.lsp.buf.execute_command({ command = "_typescript.organizeImports", arguments = { vim.fn.expand("%:p") } })
end, {})

-- lsp builtin
vim.lsp.enable({
  -- lua
  "luals",
  -- zls
  "zls",
  -- go
  "gopls"
})

-- Go-specific configuration
local go_augroup = vim.api.nvim_create_augroup("GoConfig", { clear = true })

-- Organize imports on save for Go files
vim.api.nvim_create_autocmd("BufWritePre", {
  group = go_augroup,
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params(nil, nil, 0)
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local offset_encoding = vim.lsp.get_client_by_id(res.client_id).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, offset_encoding)
        end
      end
    end
  end,
})

-- Go-specific keymaps and inlay hints
vim.api.nvim_create_autocmd("FileType", {
  group = go_augroup,
  pattern = "go",
  callback = function(ev)
    local opts = { buffer = true, silent = true }
    -- Run go tests for current file
    vim.keymap.set("n", "<leader>gt", ":!go test %:h<CR>", opts)
    -- Run go test for current function
    vim.keymap.set("n", "<leader>gf", ":!go test -run <C-r><C-w><CR>", opts)
    -- Go build
    vim.keymap.set("n", "<leader>gb", ":!go build<CR>", opts)
    -- Go run
    vim.keymap.set("n", "<leader>gr", ":!go run %<CR>", opts)

    -- Enable inlay hints for Go files
    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })

    -- Toggle inlay hints
    vim.keymap.set("n", "<leader>ih", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
    end, opts)
  end,
})
