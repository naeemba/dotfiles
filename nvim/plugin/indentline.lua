vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")
-- vim.opt.listchars = "tab:  ,extends:»,precedes:«,nbsp:×"
-- vim.opt.listchars = "tab:❘⠀,extends:»,precedes:«,nbsp:×"

-- vim.cmd([[highlight IndentBlanklineIndent1 guibg=#1f1f1f gui=nocombine]])
-- vim.cmd([[highlight IndentBlanklineIndent2 guibg=#5f5f5f gui=nocombine]])
vim.opt.termguicolors = true

vim.cmd([[highlight IndentBlanklineIndent1 guifg=#333333 gui=nocombine]])
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	-- char = "",
	-- show_trailing_blankline_indent = false,
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	char_highlight_list = {
		"IndentBlanklineIndent1",
	},
})
