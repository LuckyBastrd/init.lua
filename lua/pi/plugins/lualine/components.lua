local M = {}

-- stylua: ignore start
local modes_long = {
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

local modes_short = {
	["n"] = "RW",
	["no"] = "RO",
	["v"] = "**",
	["V"] = "**",
	["\22"] = "**", -- <C-V>
	["s"] = "S",
	["S"] = "SL",
	["\19"] = "SB", -- <C-S>
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
-- stylua: ignore end

local current_mode_map = modes_long

function M.set_mode_style(style)
	if style == "short" then
		current_mode_map = modes_short
	else
		current_mode_map = modes_long
	end
end

function M.get_mode()
	local mode_code = vim.api.nvim_get_mode().mode

	local mode_str = current_mode_map[mode_code] or mode_code

	return string.format(" %s ", mode_str):upper()
end

function M.get_fileinfo()
	local filename = vim.fn.expand("%")
	if filename == "" then
		filename = "pi.nvim"
	else
		filename = vim.fn.expand("%:t")
	end

	if filename ~= " nvim " then
		filename = " " .. filename .. " "
	end

	return "%#Normal#" .. filename .. "%#NormalNC#"
end

function M.get_git_status()
	local branch = vim.b.gitsigns_status_dict or { head = "" }

	local is_head_not_empty = branch.head and branch.head ~= ""

	if is_head_not_empty then
		return string.format("( • %s) ", branch.head)
	end

	return ""
end

function M.get_bufnr()
	return "%#Comment#" .. vim.api.nvim_get_current_buf()
end

function M.get_searchcount()
	if vim.v.hlsearch == 0 then
		return "%#Normal# %l:%c"
	end

	local ok, count = pcall(vim.fn.searchcount, { recompute = true })

	if not ok or count.current == nil or count.total == 0 then
		return ""
	end

	if count.incomplete == 1 then
		return "?/?"
	end

	local too_many = string.format(">%d", count.maxcount)
	local total = count.total > count.maxcount and too_many or count.total

	return string.format(" %#Normal# %s matches ", total)
end

function M.get_filetype()
	return "%#NormalNC#" .. vim.bo.filetype
end

function M.get_lsp_diagnostic()
	if not rawget(vim, "lsp") then
		return ""
	end

	local function get_severity(severity)
		return #vim.diagnostic.get(0, { severity = severity })
	end

	local result = {
		errors = get_severity(vim.diagnostic.severity.ERROR),
		warnings = get_severity(vim.diagnostic.severity.WARN),
		info = get_severity(vim.diagnostic.severity.INFO),
		hints = get_severity(vim.diagnostic.severity.HINT),
	}

	return string.format(" %%#DiagnosticWarn#%s %%#DiagnosticError#%s ", result.warnings or 0, result.errors or 0)
end

function M.gap()
	return " "
end

return M
