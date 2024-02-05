return {
	setup = function(opts)
		if vim.g.neovide == true then
			print("We are in gui mode - setting up gui fonts...")
			vim.cmd(":set guifont=JetbrainsMono\\ Nerd\\ Font:h18")
		end
	end,
}
