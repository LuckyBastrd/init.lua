return {
	{
		"xvzc/chezmoi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("chezmoi").setup({
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
			})
		end,
	},
	{
		"alker0/chezmoi.vim",
		init = function()
			local source_dir = vim.fn.systemlist("chezmoi source-path")[1]

			vim.g["chezmoi#use_tmp_buffer"] = true
			vim.g["chezmoi#source_dir_path"] = source_dir
		end,
	},
}
