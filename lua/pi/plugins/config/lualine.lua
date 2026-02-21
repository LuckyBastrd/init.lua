local sl = require("pi.utils.statusline")
local colors = require("pi.utils.colormypencils")
local auto = require("lualine.themes.auto")

auto.normal.c.bg = "NONE"

local has_printed = false

require("lualine").setup({
	options = {
		theme = auto,
		globalstatus = true,
		icons_enabled = false,
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = {
			{
				"mode",

				fmt = function(_)
					local mode = vim.api.nvim_get_mode().mode

					local mode_table = vim.g.lualine_short_modes and sl.modes_short or sl.modes_long

					return mode_table[mode] or mode
				end,
			},
		},
		lualine_b = {
			{
				"filename",
				file_status = false,
				newfile_status = false,
				path = 0,

				symbols = {
					unnamed = "pi.nvim",
				},

				padding = 1,
				color = function()
					local hl = sl.get_active_window_hl()

					return {
						fg = colors.to_hex(hl.fg),
						bg = hl.bg and colors.to_hex(hl.bg) or "NONE",
					}
				end,
			},
		},
		lualine_c = {
			{
				"branch",

				fmt = function(str)
					return "( • " .. str .. ") "
				end,

				padding = 0,
				color = colors.get_hl({ name = "lualine_c_y_section", fallback = "NormalNC", return_name = true }),
			},
			{
				function()
					return vim.api.nvim_get_current_buf()
				end,

				padding = { left = 0, right = 0 },
				color = "Comment",
			},
		},
		lualine_x = {
			{
				"diagnostics",

				sections = { "warn", "error" },

				diagnostics_color = {
					warn = "DiagnosticWarn",
					error = "DiagnosticError",
				},

				symbols = {
					error = "",
					warn = "",
				},

				always_visible = true,
				padding = 1,
			},
		},
		lualine_y = {
			{
				"filetype",

				padding = 0,
				color = colors.get_hl({ name = "lualine_c_y_section", fallback = "NormalNC", return_name = true }),
			},
		},
		lualine_z = {
			{
				sl.get_searchcount,

				padding = 1,
				color = function()
					local hl = sl.get_active_window_hl()

					return {
						fg = colors.to_hex(hl.fg),
						bg = hl.bg and colors.to_hex(hl.bg) or "NONE",
					}
				end,
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
