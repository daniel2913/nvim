local ns = vim.api.nvim_create_namespace("testing")
local lspec = vim.api.nvim_create_augroup("language-specific", { clear = true })


--Go
vim.api.nvim_create_autocmd('BufReadPost', {
	callback = function()
		vim.keymap.set("n", "<leader>r", vim.cmd.GoRun)
		vim.keymap.set("n", "<leader>t", vim.cmd.GoTest)
	end,
	group = lspec,
	pattern = '*.go',
})


--CPP
vim.api.nvim_create_autocmd('BufReadPost', {
	callback = function()
		vim.keymap.set("n", "<leader>r", " make | ! ./main<CR>")
		--vim.keymap.set("n", "<leader>t", vim.cmd.GoTest)
	end,
	group = lspec,
	pattern = '*.cpp',
})


--JS/TS
vim.api.nvim_create_autocmd('BufReadPost', {
	group = lspec,
	pattern = '*.js,*.jsx,*.ts,*.tsx',

	callback = function(args)
		vim.keymap.set("v", "<leader>r", ":'<,'>:w !bun run -<CR>")
		vim.keymap.set("n", "<leader>r", ":!bun run % -<CR>")

		vim.keymap.set("n", "<leader>tg", function()
			vim.fn.jobstart(
				"bunx vitest related --config=/home/daniel/.config/nvim/configs/vite.config.js --run --globals --reporter=json " ..
				vim.fn.expand("%"),
				{
					on_stdout = function(_, data)
						HandleTestResults(_, data, args)
					end
				}
			)
		end)
		vim.keymap.set("n", "<leader>tt", function()
			vim.fn.jobstart(
				"bunx vitest related --run --reporter=json " ..
				vim.fn.expand("%"),
				{
					on_stdout = function(_, data)
						HandleTestResults(_, data, args)
					end
				}
			)
		end)
	end,
})


function HandleTestResults(_, data, args)
	local stat, decoded = pcall(vim.json.decode, data[1])
	if stat == false then return end
	decoded = decoded.testResults[1].assertionResults
	vim.api.nvim_buf_clear_namespace(args.buf, ns, 0, -1)
	local failed = {}
	for _, res in ipairs(decoded) do
		if res.status == "passed" then
			for idx, line in ipairs(vim.api.nvim_buf_get_lines(args.buf, 0, -1, true)) do
				if string.match(line, ".*it%(%s*%\"" .. res.title .. "%\".*") then
					vim.api.nvim_buf_set_extmark(args.buf, ns, idx - 1, 0, { virt_text = { { "" } } })
					break
				end
			end
		else
			vim.api.nvim_buf_set_extmark(args.buf, ns, res.location.line - 1, 0, { virt_text = { { "󱂑" } } })
			table.insert(failed, {
				bufnr = args.buf,
				lnum = res.location.line - 1,
				col = 0,
				severity = vim.diagnostic.severity.ERROR,
				source = "Vitest",
				message = "Test Failed",
				user_data = {}
			})
			vim.diagnostic.setqflist({ namespace = ns, title = "Vitest", open = false })
		end
	end
	vim.diagnostic.set(ns, args.buf, failed, {})
	vim.diagnostic.setqflist({
		namespace = ns,
		open = false,
		title = "Vitest",
		severity = vim.diagnostic.severity.ERROR
	})
end
