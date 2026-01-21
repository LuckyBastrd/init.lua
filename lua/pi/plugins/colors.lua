return {
	{
		"lmantw/themify.nvim",
		lazy = false,
		priority = 999,

		config = function()
			require("themify").setup({
				--- Your list of colorschemes.
				"nyoom-engineering/oxocarbon.nvim",

				"bluz71/vim-moonfly-colors",

				{
					"EdenEast/nightfox.nvim",

					before = function()
						require("nightfox").setup({
							options = {
								transparent = true,
							},
						})
					end,
				},
			})

			vim.keymap.set("n", "<leader>tp", ":Themify<CR>", { desc = "Open Themify" })
		end,
	},
}
