local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	}
end

vim.g.vimwiki_list = { { path = '~/Documents/sync/wiki/', syntax = 'markdown', ext = '.md' } }
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({

	'ryanoasis/vim-devicons',

	require('plugins.lspconfig'),
	require('plugins.dap'),
	require('plugins.dap-ui'),
	require("plugins.go"),

	require('plugins.treesitter'),
	require('plugins.cmp'),

	require("plugins.oil"),
	require("plugins.db"),

	require('plugins.fugitive'),
	'tpope/vim-rhubarb',
	require("plugins.git"),
	require('plugins.gitsigns'),
	--require('plugins.trouble'),
	require("plugins.overseer"),

	require('plugins.telescope'),
	'BurntSushi/ripgrep',
	require('plugins.harpoon'),

	require("plugins.theme"),
	require('plugins.lualine'),
	require('plugins.vimwiki')
})
