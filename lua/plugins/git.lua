return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	branch = "master",
	config = function()
		require("neogit").setup({
			kind = "tab",
		})
		vim.keymap.set("n", "<leader>gg", ":Neogit<CR>")
		vim.keymap.set("n", "<leader>go", ":DiffviewOpen<CR>")
		vim.keymap.set("n", "<leader>gc", ":DiffviewClose<CR>")
		vim.keymap.set("n", "<leader>gh", ":DiffviewFileHistory %<CR> ")
	end
}
