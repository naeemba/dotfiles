local builtin = require("telescope.builtin")

local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
local nkeymap = vim.api.nvim_set_keymap

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local actions = require("telescope.actions")
require('telescope').setup {
        defaults = {
                vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case',
                        '-u'
                },
                mappings = {
                        i = {
                                ['<C-u>'] = false,
                                ['<C-d>'] = false,
                                ["<C-j>"] = actions.move_selection_next,
                                ["<C-k>"] = actions.move_selection_previous,
                        },
                },
        },
}

--
-- -- Custom live_grep function to search in git root
local function live_grep_git_root()
        local git_root = utils.find_git_root()
        if git_root then
                require('telescope.builtin').live_grep {
                        search_dirs = { git_root },
                }
        end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

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

local function telescope_live_grep_open_files()
        require('telescope.builtin').live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
        }
end
keymap('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
keymap('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })

keymap('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
keymap("n", "<leader>sf", function()
        builtin.find_files({ hidden = true })
end, { noremap = true, silent = true, desc = '[S]earch [F]iles' })
keymap('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sb', require('telescope.builtin').git_branches, { desc = '[S]earch [B]ranches' })
keymap('n', '<leader>sc', require('telescope.builtin').git_commits, { desc = '[S]earch [C]ommits' })
keymap('n', '<leader>sbc', require('telescope.builtin').git_bcommits, { desc = '[S]earch [B]uffer [C]ommits' })
keymap('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
