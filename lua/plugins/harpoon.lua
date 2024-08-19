return
{
	"ThePrimeagen/harpoon",
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	event = "VeryLazy",
	config =
			function()
				vim.keymap.set("n", "<leader>m", require("harpoon.mark").add_file)
				vim.keymap.set("n", "<leader><TAB>", require("harpoon.ui").toggle_quick_menu)
				vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
				vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
				vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
				vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
				vim.keymap.set("n", "<leader>i", require("harpoon.ui").nav_next)
				vim.keymap.set("n", "<leader>o", require("harpoon.ui").nav_prev)
			end
}
