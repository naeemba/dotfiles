local utils = require('utils')
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local nkeymap = vim.api.nvim_set_keymap

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- personal map
keymap("n", "<A-n>", ":terminal<CR>i", opts)
keymap("t", "<A-n>", "<C-\\><C-n>:terminal<CR>i", opts)
keymap("n", "<leader>gs", [[<Cmd>:Tig<CR>]], opts)
nkeymap("n", "<leader>d", [[<Cmd>:NvimTreeFindFile<CR>]], opts)
keymap("i", "<A-h>", "<C-\\><C-N><C-w>h", opts)
keymap("i", "<A-l>", "<C-\\><C-N><C-w>l", opts)
keymap("t", "<A-l>", "<C-\\><C-n>:bnext<CR>", opts)
keymap("t", "<A-h>", "<C-\\><C-n>:bprev<CR>", opts)
keymap("n", ";", ":", opts)
keymap("n", ":", ";", opts)

keymap("i", "<A-q>", "<Esc>:bdelete<CR>", opts)
keymap("n", "<A-q>", "<Esc>:bdelete<CR>", opts)
keymap("t", "<A-q>", "<C-\\><C-n>:bdelete!<CR>", opts)
keymap("n", "<A-l>", ":bnext<CR>", opts)
keymap("n", "<A-h>", ":bprev<CR>", opts)

nkeymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
nkeymap("v", "<", "<gv", opts)
nkeymap("v", ">", ">gv", opts)
-- stick to the previously yanked text after pasting over selected text
nkeymap("v", "p", '"_dP', opts)

-- Navigation
-- keymap("n", "<C-J>", "<C-w><C-J>", opts)
-- keymap("n", "<C-K>", "<C-w><C-K>", opts)
keymap("n", "<C-L>", "<C-w><C-L>", opts)
keymap("n", "<C-H>", "<C-w><C-H>", opts)

-- Resize
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Copy using Ctrl + c
nkeymap("n", "<C-c>", '"+y', opts)
nkeymap("v", "<C-c>", '"+y', opts)

-- Move lines up or down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set({ 'n' }, '<S-k>', function()
    require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true, desc = 'toggle signature' })

vim.keymap.set({ 'n' }, '<Leader>k', function()
    vim.lsp.buf.signature_help()
end, { silent = true, noremap = true, desc = 'toggle signature' })

-- After jump stay in middle of the screen
nkeymap("n", "<C-d>", "<C-d>zz", opts)
nkeymap("n", "<C-u>", "<C-u>zz", opts)
nkeymap("n", "n", "nzzzv", opts)
nkeymap("n", "N", "Nzzzv", opts)

nkeymap("n", '<C-j>', ":cnext<CR>", opts)
nkeymap("n", '<C-k>', ":cprev<CR>", opts)

nkeymap("v", '<leader>p', '"_dP', opts)
nkeymap("v", '<leader>y', '"+y', opts)
nkeymap("n", '<leader>y', '"+y', opts)
nkeymap("n", '<leader>Y', 'gg"+yG', opts)
