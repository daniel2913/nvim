
--signcol
vim.wo.number = true
vim.opt.relativenumber = true
vim.wo.signcolumn = 'yes'

--terminal
vim.o.completeopt = 'menuone,popup,noselect'
vim.o.termguicolors = true



--yank
vim.o.clipboard = 'unnamedplus'

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})



--keymaps
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '[q', vim.cmd.cprevious)
vim.keymap.set('n', ']q', vim.cmd.cnext)
vim.keymap.set('n', '<c-e>', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set("n", "<leader>n", vim.cmd.Ex)
vim.keymap.set("n", "<leader>N", "<c-w>v<c-w>l:Ex")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 0
vim.o.shiftwidth = 2
vim.opt.expandtab = false
vim.opt.cmdheight=0

vim.opt.updatetime = 1000
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true


vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 25
vim.opt.colorcolumn = "0"


--netrw
--
vim.g.NERDTreeHijackNetrw = 0
vim.g.ranger_replace_netrw = 1

vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_preview = 1

vim.api.nvim_create_user_command("W","w",{})
vim.api.nvim_create_user_command("Wq","wq",{})
vim.api.nvim_create_user_command("WQ","wq",{})

local netrw_keys_group = vim.api.nvim_create_augroup('NetrwKeys', { clear = true })
vim.api.nvim_create_autocmd('filetype', {
	group = netrw_keys_group,
	pattern = 'netrw',
	callback = function()
		vim.keymap.set('n', 'h', '-', { remap = true, buffer = true })
		vim.keymap.set('n', 'l', '<CR>', { remap = true, buffer = true })
	end
})
