return {
	"goolord/alpha-nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		require("pi.plugins.config.alpha")
	end,
}
