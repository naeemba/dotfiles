require('neotest-playwright').adapter({
	options = {
		keys = {
			{
				'<leader>ta',
				function()
					require('neotest').playwright.attachment()
				end,
				desc = 'Launch test attachment',
			},
		},
		preset = 'none', -- "none" | "headed" | "debug"

		get_playwright_binary = function()
			return vim.loop.cwd() .. '/node_modules/.bin/playwright'
		end,

		get_playwright_config = function()
			return vim.loop.cwd() .. '/playwright.config.ts'
		end,

		-- Controls the location of the spawned test process. Has no affect on
		-- neither the location of the binary nor the location of the playwright
		-- config file.
		get_cwd = function()
			return vim.loop.cwd()
		end,

		env = {},

		-- Extra args to always passed to playwright. These are merged with any
		-- extra_args passed to neotest's run command.
		extra_args = {},

		-- Filter directories when searching for test files. Useful in large
		-- projects (see performance notes).
		filter_dir = function(name, rel_path, root)
			return name ~= 'node_modules'
		end,

		-- Custom criteria for a file path to be a test file. Useful in large
		-- projects or projects with peculiar tests folder structure. IMPORTANT:
		-- When setting this option, make sure to be as strict as possible. For
		-- example, the pattern should not return true for jpg files that may end up
		-- in your test directory.
		is_test_file = function(file_path)
			-- By default, only returns true if a file contains one of several file
			-- extension patterns. See default implementation here: https://github.com/thenbe/neotest-playwright/blob/53c7c9ad8724a6ee7d708c1224f9ea25fa071b61/src/discover.ts#L25-L47
			local result = file_path:find('%.test%.[tj]sx?$') ~= nil or file_path:find('%.spec%.[tj]sx?$') ~= nil
			-- Alternative example: Match only files that end in `test.ts`
			local result = file_path:find('%.test%.ts$') ~= nil
			-- Alternative example: Match only files that end in `test.ts`, but only if it has ancestor directory `e2e/tests`
			local result = file_path:find('e2e/tests/.*%.test%.ts$') ~= nil
			return result
		end,

		experimental = {
			telescope = {
				-- If true, a telescope picker will be used for `:NeotestPlaywrightProject`.
				-- Otherwise, `vim.ui.select` is used.
				-- In normal mode, `<Tab>` toggles the project under the cursor.
				-- `<CR>` (enter key) applies the selection.
				enabled = false,
				opts = {},
			},
		},
	},
})

vim.api.nvim_set_keymap("n", "<leader>tr", [[<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>]],
	{ noremap = true, silent = true })
