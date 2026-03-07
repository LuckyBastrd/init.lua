return {
	{
		"lmantw/themify.nvim",
		lazy = false,
		priority = 1000,

		-- init = function()
		-- 	require("pi.utils.colormypencils").enable_autocmd()
		-- end,

		config = function()
			require("pi.plugins.config.colors")

			require("pi.utils.colormypencils").apply_override()

			require("pi.utils.colormypencils").enable_autocmd()
		end,
	},
	{
		"xiyaowong/transparent.nvim",

		config = function()
			-- Make mini.notify background transparent
			vim.cmd("hi MiniNotifyNormal guibg=NONE ctermbg=NONE")
			-- You might also need to clear border highlights
			vim.cmd("hi MiniNotifyBorder guibg=NONE ctermbg=NONE")
			require("transparent").setup({
				extra_groups = {
					"WinBar",
					"WinBarNC",
					"MiniNotifyNormal",
					"MiniNotifyTitle",
					"MiniNotifyBorder",
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
