local ignore_patterns = {
	"/submodules/",
	"run_onchange_.*",
	"run_once_.*",
	"run_after_.*",
	"%.chezmoiignore",
	"%.chezmoitemplate",
	"%.chezmoiexternal.*",
	"%.toml.tmpl",
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = vim.api.nvim_create_augroup("chezmoi_auto_apply", { clear = true }),
	pattern = { vim.g.dotfiles_path .. "/env/*" },
	callback = function(ev)
		local path = vim.api.nvim_buf_get_name(ev.buf)

		for _, dir in ipairs(ignore_patterns) do
			if path:match(dir) then
				return
			end
		end

		local bufnr = ev.buf
		local edit_watch = function()
			require("chezmoi.commands.__edit").watch(bufnr)
		end
		vim.schedule(edit_watch)
	end,
})

require("chezmoi").setup({
	edit = {
		watch = false,
		force = false,
		ignore_patterns = {
			-- "run_onchange_.*",
			-- "run_once_.*",
			-- "run_after_.*",
			-- "%.chezmoiignore",
			-- "%.chezmoitemplate",
		},
	},
	events = {
		on_open = {
			notification = {
				enable = true,
				msg = "Opened a chezmoi-managed file",
				opts = {},
			},
		},
		on_watch = {
			notification = {
				enable = true,
				msg = "This file will be automatically applied",
				opts = {},
			},
		},
		on_apply = {
			notification = {
				enable = true,
				msg = "Successfully applied",
				opts = {},
			},
		},
	},
	telescope = {
		select = { "<CR>" },
	},
})
