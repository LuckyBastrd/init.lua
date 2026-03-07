require("telescope").setup({
	defaults = {
		path_display = function(_, path)
			local subs = {
				{ "private_dot_", "." },
				{ "dot_", "." },
				{ "executable_", "" },
				{ "private_", "" },
				{ "external_", "" },
				{ "env/", "" },
				-- { "%.tmpl$", "" },
			}

			for _, sub in ipairs(subs) do
				path = path:gsub(sub[1], sub[2])
			end

			return path
		end,
	},
	extensions = {
		wrap_results = true,

		fzf = {},
	},
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("cder")
require("telescope").load_extension("find_template")

local builtin = require("telescope.builtin")
local set = vim.keymap.set

set("n", "<space>ff", builtin.find_files)
set("n", "<space>fr", builtin.oldfiles)

set("n", "<space>ft", function()
	return builtin.git_files({ cwd = vim.fn.expand("%:h") })
end)

set("n", "<space>fh", builtin.help_tags)
set("n", "<space>fg", require("pi.plugins.config.telescope.multi-ripgrep"))
set("n", "<space>fb", builtin.buffers)
set("n", "<space>/", builtin.current_buffer_fuzzy_find)

set("n", "<space>gw", builtin.grep_string)

set("n", "<space>fa", function()
	---@diagnostic disable-next-line: param-type-mismatch
	builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end)

set("n", "<space>en", function()
	builtin.find_files({
		cwd = vim.fn.stdpath("config"),
		prompt_title = "Find Neovim Config",
	})
end)

set("n", "<space>ed", function()
	builtin.find_files({
		cwd = vim.g.dotfiles_path,
		no_ignore = true,
		hidden = true,
		prompt_title = "Find Dotfiles",
		file_ignore_patterns = {
			".git",
			"nvim/",
		},
	})
end)

set("n", "<space>nt", function()
	builtin.find_files({
		prompt_title = "Find Templates",
		cwd = vim.fn.stdpath("config") .. "/templates",
		attach_mappings = function(prompt_bufnr, _)
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")

			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)

				local full_template_name = selection.value
				local template_name = vim.fn.fnamemodify(full_template_name, ":t:r")
				local ext = full_template_name:match("%.([^.]+)$") or ""
				local default_text = (ext ~= "") and ("." .. ext) or ""

				require("pi.utils.floating_window").FloatingInput({
					title = "File Name",
					default = default_text,
				}, function(input)
					if not input or input == "" then
						print("No name given")
						return
					end

					vim.cmd(string.format("Template %s %s", input, template_name))

					vim.cmd("w")

					vim.notify("󰈔 " .. input .. " created and saved!", vim.log.levels.INFO, {
						title = "Template System",
					})
				end)
			end)

			return true
		end,
	})
end, { desc = "Template -> Create File" })
