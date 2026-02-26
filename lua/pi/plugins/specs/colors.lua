return {
	-- {
	-- 	dir = "~/personal/my-plugins/ColorMyPencils",
	-- },
	{
		"lmantw/themify.nvim",
		lazy = false,
		priority = 1000,

		init = function()
			require("pi.utils.colormypencils").enable_autocmd()
		end,

		config = function()
			require("pi.plugins.config.colors")
		end,
	},
	{
		"xiyaowong/transparent.nvim",

		config = function()
			require("transparent").setup({
				extra_groups = {
					"WinBar",
					"WinBarNC",
				},

				exclude_groups = { "StatusLineNC" },
			})

			vim.keymap.set("n", "<leader>tr", ":TransparentToggle<CR>", {
				noremap = true,
				silent = true,
				desc = "Toggle Transparency",
			})
		end,
	},
}
