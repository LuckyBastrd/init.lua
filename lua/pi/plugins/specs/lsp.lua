return {
	"neovim/nvim-lspconfig",

	dependencies = {
		{
			-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "luvit-meta/library", words = { "vim%.uv" } },
					{ path = "/usr/share/awesome/lib/", words = { "awesome" } },
				},
			},
		},
		{ "Bilal2453/luvit-meta", lazy = true },
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{ "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

		{
			"dmmulroy/tsc.nvim",
			config = function()
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
