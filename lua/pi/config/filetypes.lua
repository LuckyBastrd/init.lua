vim.filetype.add({
	-- extension = {
	-- 	templ = "templ",
	-- },
	pattern = {
		-- [".*%.sh%.tmpl"] = "sh",
		[".*/run_.*%.sh%.tmpl"] = "sh",
		[".*dot_z.*%.tmpl"] = "bash",
	},
})
