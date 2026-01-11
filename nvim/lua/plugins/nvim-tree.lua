return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup({
      filters = {
        git_ignored = false,
      },
    })
    require("config.sidebar_keymap").setup({})

    -- Open nvim-tree when starting with a directory, but keep dashboard
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        local directory = vim.fn.isdirectory(data.file) == 1
        if directory then
          vim.cmd.cd(data.file)
          -- Open NvimTree without focusing it
          require("nvim-tree.api").tree.open({ focus = false })
        end
      end,
    })
  end,
}
