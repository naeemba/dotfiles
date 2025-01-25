local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{
			-- LSP Configuration & Plugins
			'neovim/nvim-lspconfig',
			dependencies = {
				-- Automatically install LSPs to stdpath for neovim
				{ 'williamboman/mason.nvim', config = true },
				'williamboman/mason-lspconfig.nvim',

				-- Useful status updates for LSP
				-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
				{ 'j-hui/fidget.nvim',       opts = {} },

				-- Additional lua configuration, makes nvim stuff amazing!
				'folke/neodev.nvim',
			},
		},
		'tpope/vim-sleuth',
		{
			-- Autocompletion
			'hrsh7th/nvim-cmp',
			dependencies = {
				-- Snippet Engine & its associated nvim-cmp source
				'L3MON4D3/LuaSnip',
				'saadparwaiz1/cmp_luasnip',

				-- Adds LSP completion capabilities
				'hrsh7th/cmp-nvim-lsp',
				'hrsh7th/cmp-path',

				-- Adds a number of user-friendly snippets
				'rafamadriz/friendly-snippets',
			},
		},
		{
			"iberianpig/tig-explorer.vim"
		},
		{              -- Useful plugin to show you pending keybinds.
			'folke/which-key.nvim',
			event = 'VimEnter', -- Sets the loading event to 'VimEnter'
			config = function() -- This is the function that runs, AFTER loading
				require('which-key').setup()

				-- Document existing key chains
				require('which-key').add {
					{ '<leader>c', group = '[C]ode' },
					{ '<leader>d', group = '[D]ocument' },
					{ '<leader>r', group = '[R]ename' },
					{ '<leader>s', group = '[S]earch' },
					{ '<leader>w', group = '[W]orkspace' },
					{ '<leader>t', group = '[T]oggle' },
					{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
				}
			end,
		},
		'lukas-reineke/lsp-format.nvim',
		{
			-- Adds git related signs to the gutter, as well as utilities for managing changes
			'lewis6991/gitsigns.nvim',
			opts = {
				-- See `:help gitsigns.txt`
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '_' },
					topdelete = { text = '‾' },
					changedelete = { text = '~' },
				},
				on_attach = function(client, bufnr)
					vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
						{ buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
					vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
						{ buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
					vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
						{ buffer = bufnr, desc = '[P]review [H]unk' })
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map({ 'n', 'v' }, ']c', function()
						if vim.wo.diff then
							return ']c'
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return '<Ignore>'
					end, { expr = true, desc = 'Jump to next hunk' })

					map({ 'n', 'v' }, '[c', function()
						if vim.wo.diff then
							return '[c'
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return '<Ignore>'
					end, { expr = true, desc = 'Jump to previous hunk' })

					-- Actions
					-- visual mode
					map('v', '<leader>hs', function()
						gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
					end, { desc = 'stage git hunk' })
					map('v', '<leader>hr', function()
						gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
					end, { desc = 'reset git hunk' })
					-- normal mode
					map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
					map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
					map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
					map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
					map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
					map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
					map('n', '<leader>hb', function()
						gs.blame_line { full = false }
					end, { desc = 'git blame line' })
					map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
					map('n', '<leader>hD', function()
						gs.diffthis '~'
					end, { desc = 'git diff against last commit' })

					-- Toggles
					map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
					map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

					-- Text object
					map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
				end,
			},
		},
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			opts = {
				transparent_background = true,
				integrations = {
					cmp = true,
					notify = true,
					which_key = true,
					gitsigns = true,
					telescope = true,
					harpoon = true,
					mason = true,
					neotest = true,
					bufferline = true,
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
						inlay_hints = {
							background = true,
						},
					},
				}
			},
			config = function(_, opts)
				require('catppuccin').setup(opts)
				vim.cmd.colorscheme 'catppuccin-mocha'
			end
		},
		{
			-- Set lualine as statusline
			'nvim-lualine/lualine.nvim',
			-- See `:help lualine.txt`
			opts = {
				options = {
					icons_enabled = false,
					theme = 'onedark',
					component_separators = '|',
					section_separators = '',
				},
			},
		},
		{
			-- Add indentation guides even on blank lines
			'lukas-reineke/indent-blankline.nvim',
			-- Enable `lukas-reineke/indent-blankline.nvim`
			-- See `:help ibl`
			main = 'ibl',
			opts = {},
		},
		{ 'numToStr/Comment.nvim',   opts = {} },
		{
			"kyazdani42/nvim-tree.lua",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			config = function()
				require("nvim-tree").setup {
					sort_by = "case_sensitive",
					view = {
						adaptive_size = true,
					},
					renderer = {
						group_empty = true,
					},
					filters = {
						dotfiles = true,
					},
				}
			end,
		},
		{
			'nvim-telescope/telescope.nvim',
			branch = '0.1.x',
			dependencies = {
				'nvim-lua/plenary.nvim',
				-- Fuzzy Finder Algorithm which requires local dependencies to be built.
				-- Only load if `make` is available. Make sure you have the system
				-- requirements installed.
				{
					'nvim-telescope/telescope-fzf-native.nvim',
					-- NOTE: If you are having trouble with this installation,
					--       refer to the README for telescope-fzf-native for more instructions.
					build = 'make',
					cond = function()
						return vim.fn.executable 'make' == 1
					end,
				},
			},
		},
		{
			-- Highlight, edit, and navigate code
			'nvim-treesitter/nvim-treesitter',
			dependencies = {
				'nvim-treesitter/nvim-treesitter-textobjects',
			},
			build = ':TSUpdate',
		},
		{ 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', after = "catppuccin", },
		{ 'windwp/nvim-autopairs' },
		{ 'windwp/nvim-ts-autotag' },
		{
			'kylechui/nvim-surround',
			version = "*",
			event = "VeryLazy",
			config = function()
				require('nvim-surround').setup({})
			end
		},
		{
			"ray-x/lsp_signature.nvim",
			event = "VeryLazy",
			opts = {
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = "single"
				}
			},
			config = function(_, opts) require 'lsp_signature'.setup(opts) end
		},
		{
			"ledger/vim-ledger"
		},
		-- {
		-- 	"zbirenbaum/copilot-cmp",
		-- 	event = "InsertEnter",
		-- 	config = function() require("copilot_cmp").setup() end,
		-- 	dependencies = {
		-- 		"zbirenbaum/copilot.lua",
		-- 		cmd = "Copilot",
		-- 		config = function()
		-- 			require("copilot").setup({
		-- 				suggestion = { enabled = false },
		-- 				panel = { enabled = false },
		-- 			})
		-- 		end,
		-- 	},
		-- },
		{
			'piero-vic/cmp-ledger',
			dependencies = {
				'nvim-lua/plenary.nvim'
			}
		},
		{
			'nvim-neotest/neotest',
			cond = not vim.g.started_by_foreign,
			dependencies = {
				'nvim-lua/plenary.nvim',
				'nvim-treesitter/nvim-treesitter',
				'nvim-neotest/nvim-nio',
				{
					'thenbe/neotest-playwright',
					dependencies = 'nvim-neotest/neotest', -- this is needed to avoid an error when neotest is lazy-loaded as a result of a key defined in neotest-playwright's config
					dev = false,
					keys = {
						{ '<leader>t.', '<cmd>NeotestPlaywrightRefresh<cr>',                       desc = '[test] [playwright] Refresh' },
						{ '<leader>tp', '<cmd>NeotestPlaywrightProject<cr>',                       desc = '[test] [playwright] Set projects' },
						{ '<leader>te', '<cmd>NeotestPlaywrightPreset<cr>',                        desc = '[test] [playwright] Set preset' },
						-- stylua: ignore
						{ '<leader>Ta', function() require('neotest').playwright.attachment() end, desc = '[test] [playwright] Launch attachment' },
					},
				},
			},
			keys = {
				-- stylua: ignore start
				{ '<leader>tr', function() require('neotest').run.run() end,                       desc = '[test] Run test' },
				{ '<leader>tR', function() require('neotest').run.run(vim.fn.expand('%')) end,     desc = '[test] Run tests in file' },
				{ '<leader>ts', function() require('neotest').run.stop() end,                      desc = '[test] Stop test' },
				{ '<leader>tO', function() require('neotest').output.open({ enter = true }) end,   desc = '[test] Open output' },
				{ '<leader>Tt', function() require('neotest.consumers.summary').toggle() end,      desc = '[test] Toggle test tree' },
				{ '<leader>To', function() require('neotest.consumers.output_panel').toggle() end, desc = '[test] Toggle output panel' },
				-- stylua: ignore end
			},
			config = function()
				require('neotest').setup({
					-- log_level = vim.log.levels.DEBUG,
					adapters = {
						require('neotest-playwright').adapter({
							options = {
								preset = 'none', -- "none" | "headed" | "debug"
								persist_project_selection = true,
								enable_dynamic_test_discovery = true,
								-- filter_dir = function(name, rel_path, root) return name ~= 'node_modules' end,
								---@param file_path string
								is_test_file = function(file_path)
									local result = file_path:find('%.spec%.[tj]s?$') ~= nil -- enforce extension
									-- local result = file_path:find('tests/.*%.test%.[jt]sx?$') ~= nil -- enforce directory and extension
									-- P({ 'is_test_file', result, file_path })
									return result
								end,
								experimental = {
									telescope = {
										enabled = true,
										-- opts = {},
									},
								},
							},
						}),
					},
					consumers = {
						playwright = require('neotest-playwright.consumers').consumers,
					},
				})
			end,
		},
		{
			"supermaven-inc/supermaven-nvim",
			config = function()
				require("supermaven-nvim").setup({})
			end,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "catpuccin" } },
	-- automatically check for plugin updates
	checker = { enabled = true },

})
