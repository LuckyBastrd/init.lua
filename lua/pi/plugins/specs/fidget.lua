return {
	{
		"j-hui/fidget.nvim",
		version = "1.6.1",

		config = function()
			require("fidget").setup({
				notification = {
					override_vim_notify = true,
					window = {
						winblend = 0, -- Transparent background
						max_width = 45,
					},
				},
			})
		end,
	},
	-- {
	-- 	"nvim-mini/mini.notify",
	-- 	version = "*",
	--
	-- 	config = function()
	-- 		require("mini.notify").setup({
	-- 			lsp_progress = {
	-- 				enable = true,
	-- 			},
	-- 			window = {
	-- 				winblend = 0,
	-- 				max_width = 0.382,
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
