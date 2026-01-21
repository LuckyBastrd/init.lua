local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local piGroup = augroup("pi", {})
local yank_group = augroup("HighlightYank", {})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("BufWritePre", {
	group = piGroup,
	pattern = "*",
	callback = function()
		vim.cmd([[ %s/\s\+$//e ]])
	end,
})

autocmd("LspAttach", {
	group = piGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		local buf_map = vim.keymap.set

		buf_map("n", "gd", vim.lsp.buf.definition, opts)
		buf_map("n", "K", vim.lsp.buf.hover, opts)
		buf_map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
		buf_map("n", "<leader>vd", vim.diagnostic.open_float, opts)
		buf_map("n", "<leader>vca", vim.lsp.buf.code_action, opts)
		buf_map("n", "<leader>vrr", vim.lsp.buf.references, opts)
		buf_map("n", "<leader>vrn", vim.lsp.buf.rename, opts)
		buf_map("i", "<C-h>", vim.lsp.buf.signature_help, opts)
		buf_map("n", "[d", vim.diagnostic.goto_next, opts)
		buf_map("n", "]d", vim.diagnostic.goto_prev, opts)
	end,
})
