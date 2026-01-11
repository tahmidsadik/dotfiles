return {
  "folke/which-key.nvim",
  --- luasnip
  { "mhinz/vim-startify",         lazy = false },
  { "dhruvasagar/vim-table-mode", event = "VeryLazy" },
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
    "mg979/vim-visual-multi",
    branch = "master",
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "folke/trouble.nvim" },
  { "nvim-lua/plenary.nvim" },

  -- prettier
  {
    "MunifTanjim/prettier.nvim",
    cond = false,
  },
  { "cohama/lexima.vim" },
  { "diepm/vim-rest-console" },


  {
    "https://tpope.io/vim/fugitive.git",
    config = function()
      require("config.git_keymaps").setup({})
    end,
  },
}
