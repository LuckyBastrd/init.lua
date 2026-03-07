return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{
			"j-hui/fidget.nvim",
			version = "1.6.1",
		},

		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

		{
			"dmmulroy/tsc.nvim",
			config = function()
				---@diagnostic disable-next-line: missing-fields
				require("tsc").setup({
					run_as_monorepo = true,
				})
			end,
		},

		{
			"pmizio/typescript-tools.nvim",
			dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		},

		-- Autoformatting
		"stevearc/conform.nvim",

		-- Schema information
		"b0o/SchemaStore.nvim",
	},

	config = function()
		require("pi.plugins.config.lsp")
	end,
}
