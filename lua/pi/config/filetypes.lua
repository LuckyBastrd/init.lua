vim.filetype.add({
	-- extension = {
	-- 	templ = "templ",
	-- },
	filename = {
		["tmux.conf.tmpl"] = "tmux",
	},
	pattern = {
		-- [".*%.sh%.tmpl"] = "sh",
		[".*/run_.*%.sh%.tmpl"] = "sh",
		[".*dot_z.*%.tmpl"] = "bash",
	},
})
