local M = {}

M.FloatingInput = function(opts, on_submit)
	opts = opts or {}

	local width = opts.width or 40
	local height = 1
	local buf = vim.api.nvim_create_buf(false, true)

	vim.bo[buf].bufhidden = "wipe"
	vim.bo[buf].buftype = "prompt"

	vim.fn.prompt_setprompt(buf, "> ")
	vim.api.nvim_buf_call(buf, function()
		vim.cmd([[syntax match FloatingInputPrompt /^> /]])
	end)

	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		style = "minimal",
		border = opts.border or "single",
		title = opts.title,
		title_pos = "center",
	})

	vim.api.nvim_set_option_value(
		"winhighlight",
		"NormalFloat:Normal,FloatBorder:Normal,FloatTitle:FloatingInputTitle",
		{ win = win }
	)

	if opts.default then
		vim.defer_fn(function()
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "> " .. opts.default })
			vim.api.nvim_win_set_cursor(win, { 1, 2 })
			vim.cmd("startinsert")
		end, 10)
	else
		vim.cmd("startinsert!")
	end

	local function close()
		if vim.api.nvim_get_mode().mode == "i" then
			vim.cmd("stopinsert")
		end

		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	vim.keymap.set("i", "<CR>", function()
		local line = vim.api.nvim_get_current_line()
		local prompt = vim.fn.prompt_getprompt(buf)
		local input = vim.trim(line:sub(#prompt + 1))

		close()

		if on_submit then
			on_submit(input)
		end
	end, { buffer = buf, silent = true })

	vim.keymap.set("i", "<Esc>", function()
		vim.cmd("stopinsert")
	end, { buffer = buf, silent = true })

	vim.keymap.set("n", "<Esc>", close, { buffer = buf, silent = true })
end

return M
