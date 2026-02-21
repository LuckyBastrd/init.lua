return {
	{
		"NeogitOrg/neogit",
		lazy = true,

		dependencies = {
			"nvim-lua/plenary.nvim",

			"sindrets/diffview.nvim",

			"nvim-telescope/telescope.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<space>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},

		config = function()
			require("neogit").setup({
				kind = "split_above",
			})
		end,
	},
}
