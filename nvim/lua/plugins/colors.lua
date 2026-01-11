-- colors lua
return {
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
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Setup kanagawa with custom configuration
      require('kanagawa').setup({
        theme = "dragon",  -- Load dragon variant by default
        background = {
          dark = "dragon",
          light = "lotus"
        },
      })

      -- Load the colorscheme
      vim.cmd([[colorscheme kanagawa]])

      -- Blink CMP documentation menu colors using Kanagawa palette
      local colors = require("kanagawa.colors").setup({ theme = "dragon" })
      vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = colors.palette.dragonBlack3 })
      vim.api.nvim_set_hl(0, "BlinkCmpLabelDetail", { bg = colors.palette.dragonBlack3 })
      vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = colors.palette.waveBlue1 })
    end,
  },
  {
    "iCyMind/NeoSolarized",
    lazy = true,
  },
  { "arcticicestudio/nord-vim", branch = "main" },
  "franbach/miramare",
  "srcery-colors/srcery-vim",
  "vimoxide/vim-cinnabar",
  "fenetikm/falcon",
  "sainnhe/forest-night",
  "sainnhe/gruvbox-material",
  "sainnhe/edge",
  "sainnhe/sonokai",
  "aonemd/quietlight.vim"
}
