return {
	"glepnir/template.nvim",
	cmd = { "Template", "TemProject" },

	config = function()
		require("template").setup({
			temp_dir = vim.fn.stdpath("config") .. "/templates",
			organization = "pi2",
			author = (os.getenv("USER") or "YourName"):gsub("^%l", string.upper),
		})
	end,
}
