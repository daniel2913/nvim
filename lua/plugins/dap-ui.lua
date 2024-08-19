return {
	"rcarriga/nvim-dap-ui",
	event = "VeryLazy",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		'theHamsta/nvim-dap-virtual-text',
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")
		require("nvim-dap-virtual-text").setup({})
		dapui.setup()
		vim.keymap.set('n', '<F5>', require 'dap'.continue)
		vim.keymap.set('n', '<F10>', require 'dap'.step_over)
		vim.keymap.set('n', '<F11>', require 'dap'.step_into)
		vim.keymap.set('n', '<F12>', require 'dap'.step_out)
		vim.keymap.set('n', '<F8>', require 'dap'.close)
		vim.keymap.set('n', '<F6>', require 'dap'.toggle_breakpoint)
		vim.keymap.set('n', '<leader>du', require 'dapui'.toggle)
		vim.keymap.set('n', '<F7>', function()
			require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))
		end)
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open({})
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close({})
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close({})
		end
	end
}
