local function run_in_toggleterm(cmd)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    cmd = cmd,
    direction = "vertical",
    close_on_exit = false,
  })
  term:toggle()
end

local run_project = function()
  local term_cmd = ""
  if vim.bo.filetype == "rust" then
    print("running rust project")
    term_cmd = "cargo run"
  elseif vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" then
    print("running typescript project")
    term_cmd = "npm start"
  elseif vim.bo.filetype == "go" then
    print("running go project")
    term_cmd = "make run"
  elseif vim.bo.filetype == "zig" then
    print("running zig project")
    term_cmd = "zig build run"
  elseif vim.bo.filetype == "sh" then
    print("running bash script")
    term_cmd = "bash %"
  end
  if term_cmd ~= "" then
    print("Executing command")
    run_in_toggleterm(term_cmd)
  else
    print("No run config configured for filetype ", vim.bo.filetype)
  end
end

return {
  setup = function(opts)
    vim.keymap.set("n", "<leader>rr", run_project, {})
  end,
}
