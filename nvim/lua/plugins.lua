local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("folke/which-key.nvim")
	use("wbthomason/packer.nvim")
	use({
		"svrana/neosolarized.nvim",
		requires = { "tjdevries/colorbuddy.nvim" },
	})
	use("nvim-lualine/lualine.nvim") -- Statusline
	use("nvim-lua/plenary.nvim") -- Common utilities
	use("onsails/lspkind-nvim") -- vscode-like pictograms
	use("hrsh7th/cmp-buffer") -- nvim-cmp source for buffer words
	use("hrsh7th/cmp-nvim-lsp") -- nvim-cmp source for neovim's built-in LSP
	use("hrsh7th/nvim-cmp") -- Completion
	use("neovim/nvim-lspconfig") -- LSP
	use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	use("glepnir/lspsaga.nvim") -- LSP UIs
	use("L3MON4D3/LuaSnip")
	use("iberianpig/tig-explorer.vim")
	use("kyazdani42/nvim-tree.lua")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use("kyazdani42/nvim-web-devicons") -- File icons
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use("norcalli/nvim-colorizer.lua")
	use("folke/zen-mode.nvim")
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({ "akinsho/bufferline.nvim", tag = "v2.*" })
	-- use 'github/copilot.vim'

	use("lewis6991/gitsigns.nvim")
	use("dinhhuy258/git.nvim") -- For git blame & browse
	use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("TaDaa/vimade")
	use("lukas-reineke/indent-blankline.nvim")
	use("ledger/vim-ledger")
	use("gpanders/editorconfig.nvim")
	use("folke/tokyonight.nvim")
end)

require("which-key").setup()
