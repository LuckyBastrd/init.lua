return {
	{
		"j-hui/fidget.nvim",
		version = "*",

		config = function()
			require("fidget").setup({
				notification = {
					override_vim_notify = true,
				},
			})
		end,
	},
}
