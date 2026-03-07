return {
	{
		"goolord/alpha-nvim",
		enabled = true,
		init = false,

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("pi.plugins.config.alpha").setup()
		end,
	},
}
