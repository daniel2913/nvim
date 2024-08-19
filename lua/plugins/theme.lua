return
{
	'folke/tokyonight.nvim',
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			style = "night",
			light_style = "day",
			transparent = true,
			styles = {
				keywords = { bold = true },
				functions = { bold = true },
				comments = {italic = true},
				floats = "transparent",
				sidebars = "transparent",
			},
			lualine_bold=true,
			hide_inactive_statusline = false,
			---@param colors ColorScheme
			on_colors = function(colors)
				colors.bg_statusline = colors.none
			end,
			plugins={
					telescope=true,
					vimwiki=true,
					trouble=true,
					treesitter=true,
					["treesitter-context"]=true,
					neogit=true,
					lazy=true,
					gitsigns=true,
					fzf=true,
					dap=true,
					cmp=true,
			}
		})
		vim.cmd.colorscheme "tokyonight-night"
	end
}
