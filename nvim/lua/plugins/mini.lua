--- mini.nvim
return {
  "echasnovski/mini.nvim",
  version = false,
  config = function(self, opts)
    require("mini.comment").setup()
    require("mini.cursorword").setup()
    require("mini.align").setup()
    require("mini.pairs").setup()
    require("mini.indentscope").setup()
  end,
}
