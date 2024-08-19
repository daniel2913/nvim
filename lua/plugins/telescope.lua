local is_inside_work_tree = {}

local project_files = function()
	local opts = {} -- define here if you want to define something
	local builtin = require('telescope.builtin')
	local themes = require('telescope.themes')
	--builtin.find_files(themes.get_ivy(opts))
	local cwd = vim.fn.getcwd()
	if cwd == nil then
		return
	end
	if is_inside_work_tree[cwd] == nil then
		vim.fn.system("git rev-parse --is-inside-work-tree")
		is_inside_work_tree[cwd] = vim.v.shell_error == 0
	end

	if is_inside_work_tree[cwd] then
		builtin.find_files(opts)
	else
		builtin.find_files(opts)
	end
end


return
{
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	event = "VeryLazy",
	dependencies = {
		'nvim-lua/plenary.nvim',
		'jonarrien/telescope-cmdline.nvim',
		'debugloop/telescope-undo.nvim',
		{
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
	},
	config = function()
		local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
		local actions = require('telescope.actions')
		require('telescope').setup {
			defaults = {
				preview = {
					hide_on_startup = true,
				},
				layout_strategy = "bottom_pane",
				mappings = {
					i = {
						["<esc>"] = actions.close,
						['<C-p>'] = require("telescope.actions.layout").toggle_preview,
						['<C-l>'] = actions.select_default,
						['<c-j>'] = actions.move_selection_next,
						['<c-k>'] = actions.move_selection_previous,
					},
					n = {
						["<esc>"] = actions.close,
						['<C-p>'] = require("telescope.actions.layout").toggle_preview,
						['<C-l>'] = actions.select_default,
						['<c-j>'] = actions.move_selection_next,
						['<c-k>'] = actions.move_selection_previous,
					},
				}
			},
			pickers = {
				buffers = {
					mappings = {
						i = {
							['<C-x>'] = actions.delete_buffer + actions.move_selection_previous,
							['<C-d>'] = actions.preview_scrolling_down,
							['<C-u>'] = actions.preview_scrolling_up,
						},
					},
				},
				current_buffer_fuzzy_find = {
					mappings = {
						i = {
							['<C-CR>'] = function(arg)
								actions.smart_send_to_loclist(arg)
							end,
							['<CR>'] = function(arg)
								actions.smart_send_to_loclist(arg)
							end
						},
					}
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				cmdline = {

				},
				undo = {

				}
			}
		}

		require('telescope').load_extension('fzf')
		require('telescope').load_extension('cmdline')
		require("telescope").load_extension("undo")

		-- See `:help telescope.builtin`
		vim.keymap.set('n', '<leader>so', require('telescope.builtin').oldfiles,
			{ desc = 'Find recently [O]pened files' })
		vim.keymap.set('n', '<leader>bb', require('telescope.builtin').buffers,
			{ desc = '[B] Find existing buffers' })
		vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
			{ desc = '[/] Fuzzily search in current buffer' })
		vim.keymap.set('n', '<leader><space>', project_files,
			{ desc = 'Git Files' })
		vim.keymap.set('n', '<leader>sf', require("telescope.builtin").find_files,
			{ desc = '[S]earch [F]iles' })
		vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
		vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<leader>gb', require('telescope.builtin').git_branches, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<leader>gc', require('telescope.builtin').git_commits, { desc = '[S]earch by [G]rep' })
		vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
		vim.keymap.set('n', '<leader>sq', require('telescope.builtin').quickfix, { desc = '[S]earch [D]iagnostics' })
		vim.keymap.set('n', '<leader>s:', require('telescope.builtin').commands, { desc = "[S]earch [C]ommands" })
		vim.keymap.set("n", "<leader>sc", "<cmd>Telescope undo<cr>")
		vim.keymap.set('n', '<leader>:', ':Telescope cmdline<CR>', { desc = "Command Line" })

		vim.keymap.set('n', '<leader>sr', function()
			require('telescope.builtin').resume()
			vim.api.nvim_feedkeys(esc, "n", false)
		end, { desc = '[S]earch [R]resume' })
	end
}
