local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end
	local nvmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
		vim.keymap.set('v', keys, func, { buffer = bufnr, desc = desc })
	end
	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
	nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
	nmap('<leader>sd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>sw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
	nmap('K', vim.lsp.buf.hover, 'hover documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nvmap('<leader>sc', require('telescope.builtin').commands, "[S]earch [C]ommands")
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	-- Create a command `:Format` local to the LSP buffer
	vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
		vim.lsp.buf.format()
	end, { desc = 'Format current buffer with LSP' })
	nmap('<leader>f', vim.lsp.buf.format, '[F]ormat File')
end


local servers = {
	tsserver = {
		settings = {
			documentformatting = false

		},
		init_options = {
			plugins = { {
				name = '@vue/typescript-plugin',
				location = "",
				languages = { 'vue' },
			}
			},
		},
		filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', "vue" },
	},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			diagnostics = { disable = { 'missing-fields' } },
		},
	},
	tailwindcss = {
		autostart = false,
		settings = {
			tailwindCSS = {
				includeLanguages = { "templ", "go" },
				experimental = {
					classRegex = {
						{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
						{ "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
					}
				}
			}
		}
	},
	biome = {},
	protolint = {},
	blade_formatter = {
		filetypes = { "blade" }
	},

	emmet_language_server = { autostart = false },

	["buf-language-server"] = {},
	intelephence = {},
	gopls = {},


	volar = {
		init_options = {
			hybridMode = true,
			typescript = {
				--tsdk = "/usr/lib/node_modules/typescript/lib"
			}
		}
	}
}

require('mason').setup({ ensure_installed = vim.tbl_keys(servers) })
require('mason-lspconfig').setup({})


require('neodev').setup()
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_registry = require('mason-registry')
local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
		'/node_modules/@vue/language-server'

servers.tsserver.init_options.plugins[1].location = vue_language_server_path

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require('lspconfig')[server_name].setup {
			autostart = (servers[server_name] or {}).autostart,
			capabilities = capabilities,
			on_attach = on_attach,
			init_options = (servers[server_name] or {}).init_options,
			settings = servers[server_name],
			filetypes = (servers[server_name] or {}).filetypes,
		}
	end,
})
