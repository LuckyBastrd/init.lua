vim.filetype.add({
	extension = {
		templ = "templ",
		tmpl = "gotmpl",
		gohtml = "gotmpl",
	},
	pattern = {
		[".*%.conf%.tmpl"] = "tmux.tmpl",
		[".*%.sh%.tmpl"] = "zsh.tmpl",
		[".*%.tmpl"] = "bash.tmpl",
		[".*%.stencil"] = "swift",
	},
	-- filename = {
	-- 	["tmux.conf.tmpl"] = "tmux",
	-- },
	-- pattern = {
	-- 	-- [".*%.sh%.tmpl"] = "sh",
	-- 	[".*/run_.*%.sh%.tmpl"] = "sh",
	-- 	-- [".*dot_z.*%.tmpl"] = "bash",
	-- 	["dot_.*%.tmpl"] = "zsh.gotmpl",
	-- 	[".*%.stencil"] = "swift",
	-- },
})
