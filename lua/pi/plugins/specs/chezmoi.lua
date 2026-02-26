return {
	{
		"xvzc/chezmoi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("pi.plugins.config.chezmoi")
		end,
	},
}
