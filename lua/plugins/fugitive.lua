return{
	'tpope/vim-fugitive',
	config= function ()
		--vim.keymap.set("n","<leader>gg",vim.cmd.Git)
		--vim.keymap.set("n","<leader>gl",":G log --oneline<CR>")
		--vim.keymap.set("n","<leader>gf",":G reflog<CR>")
	end
}
