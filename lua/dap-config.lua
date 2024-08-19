local dap = require("dap")

dap.adapters["codelldb"] = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = 8123,
	executable = {
		command = "js-debug-adapter"
	}
}

dap.configurations.typescript = {

	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},

	{
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		processId = require 'dap.utils'.pick_process,
		cwd = "${workspaceFolder}",
	},

	{
		type = "pwa-node",
		name = "TSX",
		request = "launch",
		program = "${file}",
		cwd = "${workspaceFolder}",
		runtimeArgs = {
			"--import",
			"tsx"
		},
	},
	{
		name = "Next.js: debug server-side",
		type = "pwa-node",
		request = "launch",
		command = "npm run dev"
	},
	{
		name = "Next.js: debug client-side",
		type = "chrome",
		request = "launch",
		url = "http://localhost:3000"
	},
	{
		name = "Next.js: debug full stack",
		type = "pwa-node",
		request = "launch",
		command = "npm run dev",
		serverReadyAction = {
			pattern = "- Local:.+(https?://.+)",
			uriFormat = "%s",
			action = "debugWithChrome"
		}
	},


	--[[ {
		type = "pwa-node",
		name = "TS tst",
		request = "launch",
		cwd = "${workspaceFolder}",
		runtimeArgs = {
			"-r",
			"/home/daniel/.bun/install/global/node_modules/ts-node/register",
			--"NODE_OPTIONS='--esm'",
		},
		args = {
			"${file}",
		}
	} ]]
}

dap.configurations.javascript = require("dap").configurations.typescript
