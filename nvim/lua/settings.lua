vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.shell = "zsh"

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.cmd [[set number]]
vim.cmd "set relativenumber"

vim.o.breakindent = true

vim.o.undofile = true

-- Decrease update time - autocomplete etc.
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.o.scrolloff = 8

vim.o.tabstop = 4
vim.o.tabstop = 4

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
