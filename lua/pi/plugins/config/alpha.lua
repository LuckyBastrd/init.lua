local M = {}

M.setup = function()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")

	local logo = [[
	██████╗ ██╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗
	██╔══██╗██║   ████╗  ██║██║   ██║██║████╗ ████║
	██████╔╝██║   ██╔██╗ ██║██║   ██║██║██╔████╔██║
	██╔═══╝ ██║   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
	██║     ██║██╗██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
	╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
	                · π ≈ 3.14159 ·
	]]

	dashboard.section.header.val = vim.split(logo, "\n")

	dashboard.section.buttons.val = {
		dashboard.button("SPC nf", "  Starter", "<space>nf"),
		dashboard.button("SPC nf", "  Pattern", "<space>nt"),
		dashboard.button("SPC ff", "  Explore", "<space>ff"),
		dashboard.button("SPC fr", "󰦛  Recents", "<space>fr"),
		dashboard.button("SPC fg", "󰊄  Ripgrep", "<space>fg"),
		dashboard.button("SPC en", "  Plugins", "<space>en"),
		dashboard.button("SPC ed", "  Sysconf", "<space>ed"),
		dashboard.button("     q", "󰩈  Retreat", ":qa<CR>"),
	}

	dashboard.section.header.opts.position = "center"
	dashboard.section.header.opts.hl = {
		{ { "Normal", 0, -1 } },
		{ { "Normal", 0, -1 } },
		{ { "Normal", 0, -1 } },
		{ { "Normal", 0, -1 } },
		{ { "Normal", 0, -1 } },
		{ { "Normal", 0, -1 } },
		{ { "AlphaFooter", 0, -1 } },
	}

	for _, button in ipairs(dashboard.section.buttons.val) do
		button.opts.hl = "AlphaText"
		button.opts.hl_shortcut = "AlphaText"

		button.opts.width = 32
		button.opts.position = "center"
	end

	dashboard.opts.margin = 0

	dashboard.opts.layout = {
		{ type = "padding", val = 3 },
		dashboard.section.header,
		{ type = "padding", val = 2 },
		dashboard.section.buttons,
		{ type = "padding", val = 2 },
		dashboard.section.footer,
		{ type = "padding", val = 3 },
	}

	-- if vim.o.filetype == "lazy" then
	-- 	vim.cmd.close()
	-- 	vim.api.nvim_create_autocmd("User", {
	-- 		once = true,
	-- 		pattern = "AlphaReady",
	-- 		callback = function()
	-- 			require("lazy").show()
	-- 		end,
	-- 	})
	-- end

	alpha.setup(dashboard.opts)

	vim.api.nvim_create_autocmd("User", {
		once = true,
		pattern = "LazyVimStarted",
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

			dashboard.section.footer.type = "group"

			dashboard.section.footer.val = {
				{
					type = "text",
					val = "𝝅 teaches us: structure is infinite. Edit accordingly.",
					opts = { hl = "AlphaText", position = "center" },
				},
				{
					type = "text",
					val = "· [pi.nvim] " .. stats.loaded .. "/" .. stats.count .. " | " .. ms .. "ms ·",
					opts = { hl = "AlphaFooter", position = "center" },
				},
			}

			dashboard.section.footer.opts = { spacing = 0 }

			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M
