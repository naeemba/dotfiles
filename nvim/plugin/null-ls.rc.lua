local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		bufnr = bufnr,
	})
end

local b = null_ls.builtins

null_ls.setup {
	sources = {
		b.diagnostics.eslint_d.with({
			diagnostics_format = '[eslint] #{m}\n(#{c})',
			condition = function(utils)
				return utils.root_has_file({
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json",
				})
			end,
		}),
		b.formatting.eslint_d.with({
			condition = function(utils)
				return utils.root_has_file({
					".eslintrc.js",
					".eslintrc.cjs",
					".eslintrc.yaml",
					".eslintrc.yml",
					".eslintrc.json",
				})
			end,
		}),
		b.formatting.stylua,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ bufnr = bufnr })")
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
					-- lsp_formatting(bufnr)
				end,
			})
		end
	end
}

vim.api.nvim_create_user_command(
	'DisableLspFormatting',
	function()
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
	end,
	{ nargs = 0 }
)
