local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local nkeymap = vim.api.nvim_set_keymap
-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
keymap({ 'n', 'v' }, '<Space>', '<Nop>', opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

local builtin = require("telescope.builtin")

-- See `:help telescope.builtin`
keymap('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

keymap('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
keymap("n", "<leader>sf", function()
	builtin.find_files({ hidden = true, no_ignore = true })
end, { noremap = true, silent = true, desc = '[S]earch [F]iles'  })
keymap('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

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
keymap("n", "<C-J>", "<C-w><C-J>", opts)
keymap("n", "<C-K>", "<C-w><C-K>", opts)
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

