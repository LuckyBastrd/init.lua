local setup = function()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			-- go = { "gofmt" },
			-- javascript = { "prettier" },
			-- typescript = { "prettier" },
		},
	})

	conform.formatters.injected = {
		options = {
			ignore_errors = false,
			lang_to_formatters = {
				sql = { "sleek" },
			},
		},
	}

	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("custom-conform", { clear = true }),
		callback = function(args)
			require("conform").format({
				bufnr = args.buf,
				lsp_fallback = true,
				quiet = true,
			})
		end,
	})
end

setup()

return { setup = setup }

-- return {
-- 	"stevearc/conform.nvim",
-- 	opts = {},
-- 	config = function()
-- 		require("conform").setup({
-- 			format_on_save = {
-- 				timeout_ms = 5000,
-- 				lsp_format = "fallback",
-- 			},
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				-- go = { "gofmt" },
-- 				-- javascript = { "prettier" },
-- 				-- typescript = { "prettier" },
-- 			},
-- 		})
--
-- 		vim.keymap.set("n", "<leader>f", function()
-- 			require("conform").format({ bufnr = 0 })
-- 		end)
-- 	end,
-- }
