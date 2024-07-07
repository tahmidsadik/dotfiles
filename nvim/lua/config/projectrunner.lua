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
		term_cmd = "zig run src/main.zig"
	elseif vim.bo.filetype == "sh" then
		print("running bash script")
		term_cmd = "bash %"
	elseif vim.bo.filetype == "c" then
		print("Running C project")
		term_cmd = "make run"
	end
	if term_cmd ~= "" then
		print("Executing command")
		vim.cmd(string.format(":TermExec cmd='%s'", term_cmd))
	else
		print("No run config configured for filetype ", vim.bo.filetype)
	end
end

local run_project_tests = function()
	local term_cmd = ""
	if vim.bo.filetype == "rust" then
		print("running tests")
		term_cmd = "cargo test"
	elseif vim.bo.filetype == "typescript" or vim.bo.filetype == "javascript" then
		print("running tests with npm")
		term_cmd = "npm test"
	elseif vim.bo.filetype == "go" then
		print("running go tests")
		term_cmd = "make test"
	elseif vim.bo.filetype == "zig" then
		print("running zig tests")
		term_cmd = "zig test src/main.zig"
	end
	if term_cmd ~= "" then
		print("Executing command")
		vim.cmd(string.format(":TermExec cmd='%s'", term_cmd))
	else
		print("No test config configured for filetype ", vim.bo.filetype)
	end
end

return {
	setup = function(opts)
		vim.keymap.set("n", "<leader>rr", run_project, {})
		vim.keymap.set("n", "<leader>rt", run_project_tests, {})
	end,
}
