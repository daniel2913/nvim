return
{
	-- Autocompletion
	'hrsh7th/nvim-cmp',
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		'L3MON4D3/LuaSnip',
		'saadparwaiz1/cmp_luasnip',

		-- Adds LSP completion capabilities
		'hrsh7th/cmp-nvim-lsp',

		-- Adds a number of user-friendly snippets
		'rafamadriz/friendly-snippets',
	},
	config = function()
		local cmp = require 'cmp'
		local ls = require 'luasnip'
		ls.filetype_extend("javascript", { "jsdoc" })
		require('luasnip.loaders.from_vscode').lazy_load()
		ls.config.setup {}

		cmp.setup {
			snippet = {
				expand = function(args)
					ls.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				['<C-j>'] = cmp.mapping.select_next_item(),
				['<C-k>'] = cmp.mapping.select_prev_item(),
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-l>'] = cmp.mapping.confirm(),
			},
			sources = cmp.config.sources {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = '' },
			},
		}
		vim.keymap.set("i", "<cs-l>", ls.expand)
		vim.keymap.set("i", "<c-l>", function() ls.jump(1) end)
		vim.keymap.set("i", "<c-h>", function() ls.jump(-1) end)
	end
}
