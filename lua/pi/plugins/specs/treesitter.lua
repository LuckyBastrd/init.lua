return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",

		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				after = "nvim-treesitter",
			},
		},

		config = function()
			require("pi.plugins.config.tresitter").setup()
		end,
	},
}
