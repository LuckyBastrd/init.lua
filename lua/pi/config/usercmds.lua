local usercmd = vim.api.nvim_create_user_command

usercmd("Unique", function()
	local start_line = vim.fn.getpos("'<")[2]
	local end_line = vim.fn.getpos("'>")[2]

	local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

	local seen = {}
	local uniq = {}
	for _, l in ipairs(lines) do
		if not seen[l] then
			seen[l] = true
			table.insert(uniq, l)
		end
	end

	vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, uniq)
end, { range = true })

usercmd("LualineShortMode", function()
	vim.g.lualine_short_modes = not vim.g.lualine_short_modes

	require("pi.utils.statusline").save(vim.g.lualine_short_modes)

	local status = vim.g.lualine_short_modes and "ON" or "OFF"
	vim.notify("Lualine short modes: " .. status)
end, {})
