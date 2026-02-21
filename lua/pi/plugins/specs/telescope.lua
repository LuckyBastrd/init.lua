return {
	"nvim-telescope/telescope.nvim",
	version = "*",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"Zane-/cder.nvim",
	},

	config = function()
		require("pi.plugins.config.telescope")
	end,
}
