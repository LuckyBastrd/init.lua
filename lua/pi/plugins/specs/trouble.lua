return {
	"folke/trouble.nvim",

	config = function()
		local trouble = require("trouble")

		trouble.setup({})

		local map = vim.keymap.set

		map("n", "<space>ta", function()
			trouble.toggle("diagnostics")
		end, { desc = "Diagnostics (Trouble)" })

		map("n", "<space>tc", function()
			require("trouble").toggle({
				mode = "diagnostics",
				focus = false,
				filter = { buf = 0 },
			})
		end, { desc = "Buffer Diagnostics (Trouble)" })

		map("n", "<space>ts", function()
			trouble.toggle("symbols", { focus = false })
		end, { desc = "Symbols (Trouble)" })

		map("n", "<space>cl", function()
			trouble.toggle("lsp", { focus = false, win = { position = "right" } })
		end, { desc = "LSP Definitions / References" })

		vim.keymap.set("n", "<space>]t", function()
			require("trouble").next({ jump = true })
		end, { desc = "Next trouble item" })

		vim.keymap.set("n", "<space>[t", function()
			require("trouble").prev({ jump = true })
		end, { desc = "Previous trouble item" })
	end,
}
