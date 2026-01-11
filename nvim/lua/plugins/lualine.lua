return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = require("config.statusline").setup,
}
