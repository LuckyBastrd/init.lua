-- require("pi.utils.chezmoi")
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command

local piGroup = augroup("pi", {})
local check_group = augroup("bufcheck", { clear = true })
local yank_group = augroup("HighlightYank", {})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("FileType", {
	group = piGroup,
	callback = function()
		vim.opt_local.formatoptions:remove({ "o", "r" })
	end,
})

autocmd("BufWritePre", {
	group = piGroup,
	pattern = "*",
	callback = function()
		local view = vim.fn.winsaveview()
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.winrestview(view)
	end,
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
-- 	group = check_group,
-- 	pattern = "*.swift",
-- 	callback = function(ev)
-- 		local lines = #vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
--
-- 		if lines > 1 then
-- 			return
-- 		end
--
-- 		local filename = string.match(ev.file, "([^/]*)%.swift")
-- 		local name = filename
-- 		local projectname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
-- 		local fullname = (os.getenv("USER") or "YourName"):gsub("^%l", string.upper)
-- 		local organization = "its-pi"
--
-- 		local basepath = os.getenv("HOME") .. "/.config/nvim/templates/swift/"
-- 		local templates = { "View", "ViewModel", "Builder", "Router", "Tests", "Spec" }
--
-- 		local template
-- 		local cursor
--
-- 		for _, templateSuffix in ipairs(templates) do
-- 			if vim.endswith(filename, templateSuffix) then
-- 				template = vim.fn.readfile(basepath .. string.lower(templateSuffix) .. ".txt")
-- 				name = string.gsub(name, templateSuffix, "")
-- 				break
-- 			end
-- 		end
--
-- 		template = template or vim.fn.readfile(basepath .. "default.txt")
--
-- 		for i = 1, #template do
-- 			template[i] = string.gsub(template[i], "{filename}", filename)
-- 			template[i] = string.gsub(template[i], "{projectname}", projectname)
-- 			template[i] = string.gsub(template[i], "{name}", fullname)
-- 			template[i] = string.gsub(template[i], "{date}", os.date("%d/%m/%Y"))
-- 			template[i] = string.gsub(template[i], "{year}", os.date("%Y"))
-- 			template[i] = string.gsub(template[i], "{organization}", organization)
--
-- 			if cursor == nil and string.find(template[i], "{cursor}") then
-- 				cursor = { i, tonumber(string.find(template[i], "{cursor}")) + 1 }
-- 			end
-- 			template[i] = string.gsub(template[i], "{cursor}", " ")
-- 		end
--
-- 		vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, template)
--
-- 		if cursor then
-- 			vim.api.nvim_win_set_cursor(0, cursor)
-- 		end
--
-- 		-- vim.cmd("w")
-- 	end,
-- })
