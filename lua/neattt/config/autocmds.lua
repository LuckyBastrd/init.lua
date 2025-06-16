-- lua/neattt/config/autocmds.lua
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local neatttGroup = augroup("neattt", {})
local yank_group = augroup("HighlightYank", {})

-- Highlight on yank
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

-- Trim trailing whitespace
autocmd("BufWritePre", {
	group = neatttGroup,
	pattern = "*",
	callback = function()
		vim.cmd([[ %s/\s\+$//e ]])
	end,
})

-- Set color scheme on BufEnter
autocmd("BufEnter", {
	group = neatttGroup,
	callback = function()
		vim.cmd.colorscheme("oxocarbon")
	end,
})

-- Autocommands for gitsigns.nvim
autocmd("BufRead", {
	pattern = "*",
	callback = function()
		local git_dir = vim.fn.expand("%:p:h")
		local is_git_repo = vim.fn.system("git -C " .. git_dir .. " rev-parse")

		if vim.v.shell_error == 0 then
			require("gitsigns").setup()
		end
	end,
})

-- Autocommands for conform
autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		require("conform").format()
	end,
})

-- LSP key mappings
autocmd("LspAttach", {
	group = neatttGroup,
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
