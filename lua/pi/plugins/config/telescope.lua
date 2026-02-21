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

local builtin = require("telescope.builtin")
local set = vim.keymap.set

set("n", "<space>ff", builtin.find_files)

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
