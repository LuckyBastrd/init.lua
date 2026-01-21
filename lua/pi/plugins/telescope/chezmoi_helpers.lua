local M = {}

function M.transformer(opts)
	opts = opts or {}

	local original_maker = require("telescope.make_entry").gen_from_file(opts)
	local devicons = require("nvim-web-devicons")
	local entry_display = require("telescope.pickers.entry_display")

	local startup_root = opts.startup_root or vim.fn.getcwd()
	local current_cwd = opts.cwd or vim.fn.getcwd()

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = 2 },
			{ remaining = true },
		},
	})

	local function make_display(entry)
		return displayer({
			{ entry.icon, entry.icon_hl },
			entry.display_name,
		})
	end

	return function(line)
		local entry = original_maker(line)
		if not entry or not entry.value then
			return nil
		end

		local display_path = entry.value

		if display_path == "." then
			if current_cwd == startup_root then
				return nil
			else
				entry.display = "Back to Startup Directory"
				entry.ordinal = "Startup Directory"
				entry.value = startup_root
				entry.path = startup_root
				entry.icon = ""
				entry.icon_hl = "Special"
				entry.display_name = "Back to Startup Directory"
			end

			entry.display = make_display
			return entry
		end

		if display_path == ".." then
			entry.display = ".."
			entry.ordinal = ".."
			local parent_dir = vim.fn.fnamemodify(current_cwd, ":h")
			entry.value = parent_dir
			entry.path = parent_dir
			entry.icon = ""
			entry.icon_hl = "Special"
			entry.display_name = ".."
			entry.display = make_display
			return entry
		end

		local replacements = {
			{ "private_dot_", "." },
			{ "dot_", "." },
			{ "executable_", "" },
			{ "private_", "" },
			{ "external_", "" },
		}

		for _, r in ipairs(replacements) do
			local pattern, replacement = r[1], r[2]
			display_path = display_path:gsub("^" .. pattern, replacement)
			display_path = display_path:gsub("/" .. pattern, "/" .. replacement)
		end

		local icon, icon_hl
		if opts.is_directory then
			icon = ""
			icon_hl = "Directory"
		else
			local filename = vim.fn.fnamemodify(entry.path, ":t")
			local extension = vim.fn.fnamemodify(entry.path, ":e")

			icon, icon_hl = devicons.get_icon(filename, extension, { default = true })
		end

		entry.icon = icon
		entry.icon_hl = icon_hl
		entry.display_name = display_path
		entry.display = make_display
		entry.ordinal = display_path

		return entry
	end
end

return M
