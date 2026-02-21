local M = {}

local function resolve(name)
	if not name then
		return nil
	end

	local ok, hl = pcall(vim.api.nvim_get_hl, 0, {
		name = name,
		link = false,
	})

	if ok and hl and (hl.fg ~= nil or hl.bg ~= nil) then
		return hl
	end
end

function M.get_hl(opts)
	opts = opts or {}

	local error = { fg = 0xFF0000, bg = 0xFF0000 }
	local error_hl_name = "DiagnosticError"

	if opts.return_name then
		if resolve(opts.name) then
			return opts.name
		end

		if type(opts.fallback) == "string" and resolve(opts.fallback) then
			return opts.fallback
		end

		return error_hl_name
	end

	local hl = resolve(opts.name)
	if hl then
		return hl
	end

	if type(opts.fallback) == "string" then
		hl = resolve(opts.fallback)
		if hl then
			return hl
		end
	end

	return type(opts.fallback) == "table" and opts.fallback or error
end

function M.to_hex(color)
	return string.format("#%06x", color or 0)
end

function M.to_style_names(hl)
	if type(hl) ~= "table" then
		return ""
	end

	local attrs = { "bold", "italic", "underline", "undercurl", "reverse" }
	local active_styles = {}

	for _, attr in ipairs(attrs) do
		if hl[attr] then
			table.insert(active_styles, attr)
		end
	end

	return table.concat(active_styles, ",")
end

local function apply_highlights(defs)
	defs = defs or {}

	for group, hl_opts in pairs(defs) do
		vim.api.nvim_set_hl(0, group, hl_opts)
	end
end

local function apply_statusline_highlight()
	local normal = M.get_hl({ name = "Normal" })
	local statusline = M.get_hl({ name = "StatusLine" })

	vim.api.nvim_set_hl(0, "StatusLine", {
		fg = normal.fg,
		bg = normal.bg,
		bold = statusline.bold,
		italic = statusline.italic,
	})
end

local highlight_overrides = {
	oxocarbon = function()
		if vim.o.background == "dark" then
			--
		else
			--
		end
	end,

	moonfly = function()
		local normal = M.get_hl({ name = "Normal" })
		local statusline_nc = M.get_hl({ name = "StatusLineNC" })
		local vert_split = M.get_hl({ name = "VertSplit" })

		apply_highlights({
			lualine_c_y_section = { fg = "#E4E4E4" },
			StatusLineNC = {
				fg = "#C6C6C6",
				bg = statusline_nc.bg,
				bold = statusline_nc.bold,
				italic = statusline_nc.italic,
			},
			VertSplit = {
				fg = vert_split.fg,
				bg = normal.bg,
			},
		})
	end,

	carbonfox = function()
		local statusline_nc = M.get_hl({ name = "StatusLineNC" })

		apply_highlights({
			StatusLineNC = {
				fg = "#F2F4F8",
				bg = "#282828",
				bold = statusline_nc.bold,
				italic = statusline_nc.italic,
			},
		})
	end,
}

local function apply_override()
	local cs = vim.g.colors_name

	apply_statusline_highlight()

	if highlight_overrides[cs] then
		highlight_overrides[cs]()
	end
end

function M.enable_autocmd()
	local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", { clear = true })

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = custom_highlight,
		callback = apply_override,
	})
end

return M
