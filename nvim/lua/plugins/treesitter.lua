return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "go",
        "gomod",
        "gowork",
        "gosum",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  }
}
