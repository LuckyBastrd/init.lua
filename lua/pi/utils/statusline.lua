local colors = require("pi.utils.colormypencils")

local M = {}

-- stylua: ignore start
M.modes_long = {
    ['n']      = 'NO',
    ['no']     = 'OP',
    ['nov']    = 'OC',
    ['noV']    = 'OL',
    ['no\22']  = 'OB',
    ['niI']    = 'IN',
    ['niR']    = 'RE',
    ['niV']    = 'RV',
    ['nt']     = 'NT',
    ['ntT']    = 'TM',
    ['v']      = 'VI',
    ['vs']     = 'VI',
    ['V']      = 'VL',
    ['Vs']     = 'VL',
    ['\22']    = 'VB',
    ['\22s']   = 'VB',
    ['s']      = 'SE',
    ['S']      = 'SL',
    ['\19']    = 'SB',
    ['i']      = 'IN',
    ['ic']     = 'IC',
    ['ix']     = 'IX',
    ['R']      = 'RE',
    ['Rc']     = 'RC',
    ['Rx']     = 'RX',
    ['Rv']     = 'RV',
    ['Rvc']    = 'RC',
    ['Rvx']    = 'RX',
    ['c']      = 'CO',
    ['cv']     = 'CV',
    ['ce']     = 'CE',
    ['r']      = 'RR',
    ['rm']     = 'PM',
    ['r?']     = '??',
    ['!']      = 'SH',
    ['t']      = 'TE',
}

M.modes_short = {
	["n"] = "RW",
	["no"] = "RO",
	["v"] = "**",
	["V"] = "**",
	["\22"] = "**",
	["s"] = "S",
	["S"] = "SL",
	["\19"] = "SB",
	["i"] = "**",
	["ic"] = "**",
	["R"] = "RA",
	["Rv"] = "RV",
	["c"] = "VIEX",
	["cv"] = "VIEX",
	["ce"] = "EX",
	["r"] = "r",
	["rm"] = "r",
	["r?"] = "r",
	["!"] = "!",
	["t"] = "TM",
}

local skip_colorschemes = {
	["oxocarbon"] = true,
}
-- stylua: ignore end

function M.get_searchcount()
	if vim.v.hlsearch == 0 then
		return "%l:%c"
	end

	local ok, count = pcall(vim.fn.searchcount, { recompute = true })
	if not ok or count.current == nil or count.total == 0 then
		return ""
	end

	if count.incomplete == 1 then
		return "?/?"
	end

	local too_many = string.format(">%d", count.maxcount)
	local total = (count.total > count.maxcount) and too_many or count.total

	return string.format("%s matches", total)
end

function M.get_active_window_hl()
	local is_float = vim.api.nvim_win_get_config(0).relative ~= ""

	local normal_hl = colors.get_hl({ name = "Normal" })
	local is_transparent = not normal_hl.bg

	local group_name = is_float and "StatusLineNC" or "StatusLine"
	local raw_hl = colors.get_hl({ name = group_name, return_name = false })
	local base_hl = vim.tbl_extend("force", {}, raw_hl)

	if not is_float and is_transparent then
		base_hl.bg = nil
	end

	return base_hl
end

-- save and load value
local paths = require("pi.utils.persist_paths")
local persist_path = paths.statusline .. "/lualine_short_modes_persist.lua"

function M.save(value)
	local content = string.format("return %s", tostring(value))
	vim.fn.writefile(vim.split(content, "\n"), persist_path)
end

function M.load()
	local status, value = pcall(dofile, persist_path)

	if status and type(value) == "boolean" then
		return value
	end

	return false
end

return M
