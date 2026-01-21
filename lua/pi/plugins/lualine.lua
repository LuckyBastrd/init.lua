return {
	{
		"nvim-lualine/lualine.nvim",

		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			local components = require("pi.plugins.lualine.components")
			--- components.set_mode_style("short")

			require("lualine").setup({
				options = {
					theme = "auto",
					globalstatus = true,
					component_separators = "",
					section_separators = "",
				},
				sections = {
					lualine_a = {
						{
							components.gap,
							padding = 0,
							color = { bg = "none" },
						},
						{

							function()
								return components.get_mode()
									.. components.get_fileinfo()
									.. components.get_git_status()
									.. components.get_bufnr()
							end,
							padding = 0,
						},
					},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {
						{
							function()
								return components.get_lsp_diagnostic()
									.. components.get_filetype()
									.. components.get_searchcount()
							end,
							color = { bg = "none" },
							padding = 0,
						},
					},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = {},
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
