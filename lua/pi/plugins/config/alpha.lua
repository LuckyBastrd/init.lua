local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Your header ASCII art
local header = {
	"⠀⠀⠀⠀⢀⣠⣤⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣶⣦⠀",
	"⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃",
	"⠀⣴⣿⣿⣿⣿⣿⠿⢿⣿⣿⣿⣿⡟⠛⠛⠛⣿⣿⣿⣿⣿⠛⠛⠛⠛⠛⠛⠛⠁⠀",
	"⠘⣿⣿⣿⣿⠟⠁⠀⢸⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠉⠛⠛⠁⠀⠀⠀⢸⣿⣿⣿⣿⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡿⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⡇⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⠁⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀",
	"⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⡟⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⠀⢀⣤⣤⡀⠀",
	"⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⠁⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⠀⠀⢠⣿⣿⣿⣿⡄",
	"⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⣿⣤⣤⣾⣿⣿⣿⣿⠁",
	"⠀⠀⠀⢰⣿⣿⣿⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀",
	"⠀⠀⠀⠀⠻⠿⠿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⠿⠿⠿⠟⠋⠀⠀⠀",
}

-- Dashboard buttons
local buttons = {
	dashboard.button("n", "  New file", ":ene <BAR> startinsert<CR>"),
	{ type = "padding", val = 1 },
	dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
	{ type = "padding", val = 1 },
	dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
	{ type = "padding", val = 1 },
	dashboard.button("g", "  Find text", ":Telescope live_grep<CR>"),
	{ type = "padding", val = 1 },
	dashboard.button("c", "  Config", ":Telescope find_files cwd=~/.config/nvim<CR>"),
	{ type = "padding", val = 1 },
	dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Footer
local footer = {
	"𝝅 teaches us: structure is infinite. Edit accordingly.",
}

-- Estimate total content height to center vertically
local total_lines = #header + #buttons + #footer + 4

local win_height = vim.fn.winheight(0)
local top_padding = math.floor((win_height - total_lines) / 2)

-- Compose layout
dashboard.config.layout = {
	{ type = "padding", val = top_padding },
	{ type = "text", val = header, opts = { position = "center" } },
	{ type = "padding", val = 2 },
	{ type = "group", val = buttons, opts = { position = "center" } },
	{ type = "padding", val = 2 },
	{ type = "text", val = footer, opts = { position = "center" } },
}

-- Highlights
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Comment"

-- Setup Alpha
alpha.setup(dashboard.config)
