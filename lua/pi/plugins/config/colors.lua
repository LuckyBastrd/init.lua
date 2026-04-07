local set = vim.keymap.set

-- Themify - colorscheme
require("themify").setup({
	{
		"bluz71/vim-moonfly-colors",
		name = "moonfly",
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
	},
	{
		"EdenEast/nightfox.nvim",
	},
	"wnkz/monoglow.nvim",
})

set("n", "<space>cp", ":Themify<CR>", { desc = "Open Themify" })
