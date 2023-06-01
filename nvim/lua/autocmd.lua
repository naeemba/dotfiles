vim.api.nvim_create_autocmd("FileType", {
	pattern = "ledger",
	callback = function()
		vim.keymap.set("i", "<leader>ld", "<C-O>:call ledger#transaction_date_set(line('.'), 'primary')<Cr><END>")
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.ledger",
	command = "LedgerAlignBuffer",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.ts,*.tsx",
	command = "EslintFixAll",
})
