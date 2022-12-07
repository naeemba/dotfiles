local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
  return
end

-- local tree_cb = nvim_tree_config.nvim_tree_callback

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_keymap('n', '<leader>d', [[<Cmd>:NvimTreeFindFile<CR>]], { noremap = true, silent = true })

nvim_tree.setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
-- {
-- renderer = {
-- 	add_trailing = false,
-- 	group_empty = false,
-- 	highlight_git = false,
-- 	highlight_opened_files = "none",
-- 	root_folder_modifier = ":t",
-- 	indent_markers = {
-- 		enable = false,
-- 		icons = {
-- 			corner = "└ ",
-- 			edge = "│ ",
-- 			none = "  ",
-- 		},
-- 	},
-- 	icons = {
-- 		webdev_colors = true,
-- 		git_placement = "before",
-- 		padding = " ",
-- 		symlink_arrow = " ➛ ",
-- 		show = {
-- 			file = true,
-- 			folder = true,
-- 			folder_arrow = true,
-- 			git = true,
-- 		},
-- 		glyphs = {
-- 			default = "",
-- 			symlink = "",
-- 			folder = {
-- 				default = "",
-- 				open = "",
-- 				empty = "",
-- 				empty_open = "",
-- 				symlink = "",
-- 				symlink_open = "",
-- 			},
-- 			git = {
-- 				unstaged = "",
-- 				staged = "S",
-- 				unmerged = "",
-- 				renamed = "➜",
-- 				untracked = "U",
-- 				deleted = "",
-- 				ignored = "◌",
-- 			},
-- 		},
-- 	},
-- },
-- update_cwd = true,
-- view = {
-- 	width = 50,
-- 	-- height = 30,
-- 	hide_root_folder = false,
-- 	side = "left",
-- 	-- auto_resize = true,
-- 	mappings = {
-- 		custom_only = false,
-- 		list = {
-- 			{ key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
-- 			{ key = "h", cb = tree_cb "close_node" },
-- 			{ key = "v", cb = tree_cb "vsplit" },
-- 		},
-- 	},
-- 	number = false,
-- 	relativenumber = false,
-- },
-- }
