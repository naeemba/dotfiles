local keymap = vim.keymap

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards ---- not useful at all
-- keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap.set("n", "te", ":tabedit")
-- Split window
-- keymap.set("n", "ss", ":split<Return><C-w>w")
-- keymap.set("n", "sv", ":vsplit<Return><C-w>w")
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
-- keymap.set("", "sh", "<C-w>h")
-- keymap.set("", "sk", "<C-w>k")
-- keymap.set("", "sj", "<C-w>j")
-- keymap.set("", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Switch ; and :
keymap.set("n", ";", ":", { noremap = true })
keymap.set("n", ":", ";", { noremap = true })

-- Resize window
keymap.set("n", "<leader><C-K>", [[<Cmd>:resize -5<CR>]], { silent = true, noremap = true })
keymap.set("n", "<leader><C-J>", [[<Cmd>:resize +5<CR>]], { silent = true, noremap = true })
keymap.set("n", "<leader><C-L>", [[<Cmd>:vertical resize +10<CR>]], { silent = true, noremap = true })
keymap.set("n", "<leader><C-H>", [[<Cmd>:vertical resize -10<CR>]], { silent = true, noremap = true })

-- Move window
keymap.set("n", "<C-J>", "<C-w><C-J>", { silent = true, noremap = true })
keymap.set("n", "<C-K>", "<C-w><C-K>", { silent = true, noremap = true })
keymap.set("n", "<C-L>", "<C-w><C-L>", { silent = true, noremap = true })
keymap.set("n", "<C-H>", "<C-w><C-H>", { silent = true, noremap = true })

-- Navigation
keymap.set("i", "<A-q>", "<Esc>:bdelete<CR>", { silent = true, noremap = true })
keymap.set("n", "<A-q>", "<Esc>:bdelete<CR>", { silent = true, noremap = true })
keymap.set("n", "<A-l>", ":bnext<CR>", { silent = true, noremap = true })
keymap.set("n", "<A-h>", ":bprev<CR>", { silent = true, noremap = true })

keymap.set("n", "<A-n>", ":terminal<CR>i", { silent = true, noremap = true })
keymap.set("i", "<A-h>", "<C-\\><C-N><C-w>h", { silent = true, noremap = true })
keymap.set("i", "<A-j>", "<C-\\><C-N><C-w>j", { silent = true, noremap = true })
keymap.set("i", "<A-k>", "<C-\\><C-N><C-w>k", { silent = true, noremap = true })
keymap.set("i", "<A-l>", "<C-\\><C-N><C-w>l", { silent = true, noremap = true })
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { silent = true, noremap = true })

keymap.set("t", "<A-l>", "<C-\\><C-n>:bnext<CR>", { silent = true, noremap = true })
keymap.set("t", "<A-h>", "<C-\\><C-n>:bprev<CR>", { silent = true, noremap = true })
keymap.set("t", "<A-q>", "<C-\\><C-n>:bdelete!<CR>", { silent = true, noremap = true })
keymap.set("t", "<A-n>", "<C-\\><C-n>:terminal<CR>i", { silent = true, noremap = true })

keymap.set("n", "<leader>gs", [[<Cmd>:Tig<CR>]], { noremap = true })
