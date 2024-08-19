return {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 opts = {
 },
	config = function()
		local trouble =require('trouble')
		trouble.setup()
		vim.keymap.set("n","<leader>l",trouble.open)
	end
}
