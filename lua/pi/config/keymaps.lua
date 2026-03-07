local sl = require("pi.utils.statusline")

local set = vim.keymap.set
local k = vim.keycode
local f = require("pi.utils.f")
local fn = f.fn

-- -- help me
-- local modes = { "n", "i", "v" }
--
-- for _, mode in ipairs(modes) do
-- 	set(mode, "<Up>", "<Nop>", { noremap = true, silent = true })
-- 	set(mode, "<Down>", "<Nop>", { noremap = true, silent = true })
-- 	set(mode, "<Left>", "<Nop>", { noremap = true, silent = true })
-- 	set(mode, "<Right>", "<Nop>", { noremap = true, silent = true })
-- end

set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
set("n", "<leader><leader>x", "<cmd>source %<CR>", { desc = "Execute the current file" })

-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<CR>", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.v.hlsearch == 1 then
		sl.clear_search()
		vim.cmd.nohl()
		return ""
	else
		return k("<CR>")
	end
end, { expr = true })

set("n", "]d", fn(vim.diagnostic.jump, { count = 1, float = true }))
set("n", "[d", fn(vim.diagnostic.jump, { count = -1, float = true }))

-- These mappings control the size of splits (height/width)
set("n", "<M-n>", "<c-w>5<")
set("n", "<M-e>", "<c-w>5>")
set("n", "<M-t>", "<C-W>+")
set("n", "<M-s>", "<C-W>-")

set("n", "<M-j>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! ]c]])
	else
		vim.cmd([[m .+1<CR>==]])
	end
end)

set("n", "<M-k>", function()
	if vim.opt.diff:get() then
		vim.cmd([[normal! [c]])
	else
		vim.cmd([[m .-2<CR>==]])
	end
end)

set("n", "j", function(...)
	local count = vim.v.count

	if count == 0 then
		return "gj"
	else
		return "j"
	end
end, { expr = true })

set("n", "k", function(...)
	local count = vim.v.count

	if count == 0 then
		return "gk"
	else
		return "k"
	end
end, { expr = true })

set("n", "<space>tt", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
end)

vim.keymap.set("n", "]]", "<cmd>cnext<CR>", { silent = true })
vim.keymap.set("n", "[[", "<cmd>cprev<CR>", { silent = true })

set("n", "<space>rn", function()
	return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

set("n", "<space>nf", function()
	require("pi.utils.floating_window").FloatingInput({ title = "New File" }, function(name)
		if name ~= "" then
			vim.cmd("edit " .. name)
		end
	end)
end)

--set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
