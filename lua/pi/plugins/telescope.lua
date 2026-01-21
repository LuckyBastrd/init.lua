return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.8",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"Zane-/cder.nvim",
	},

	config = function()
		local startup_root = vim.fn.getcwd()
		local chezmoi_helpers = require("pi.plugins.telescope.chezmoi_helpers")

		local entry_maker = chezmoi_helpers.transformer({ startup_root = startup_root })

		require("telescope").setup({
			pickers = {
				find_files = { entry_maker = entry_maker },
				git_files = { entry_maker = entry_maker },
				grep_string = { entry_maker = entry_maker },
				live_grep = { entry_maker = entry_maker },
			},
			extensions = {
				cder = {
					entry_maker = entry_maker,
					dir_command = { "sh", "-c", "echo '.' && echo '..' && fd --type d ." },
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		require("telescope").load_extension("fzf")
		require("telescope").load_extension("cder")

		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find files" })

		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })

		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Grep string" })

		vim.keymap.set("n", "<leader>pws", function()
			builtin.grep_string({ search = vim.fn.expand("<cword>") })
		end, { desc = "Grep word" })

		vim.keymap.set("n", "<leader>pWs", function()
			builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
		end, { desc = "Grep WORD" })

		vim.keymap.set("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })

		vim.keymap.set("n", "<leader>cd", function()
			local current_dir = vim.fn.getcwd()

			require("telescope").extensions.cder.cder(require("telescope.themes").get_dropdown({
				cwd = current_dir,
				dir_command = { "sh", "-c", "echo '..' && echo '.' && fd --type d ." },

				entry_maker = chezmoi_transformer({
					is_directory = true,
					startup_root = startup_root,
					cwd = current_dir,
				}),

				previewer = false,
				prompt_title = "Change Directory (" .. vim.fn.fnamemodify(current_dir, ":t") .. ")",
				winblend = 10,
				layout_config = { width = 0.5, height = 0.4 },
			}))
		end, { desc = "Change directory (cder)" })
	end,
}
