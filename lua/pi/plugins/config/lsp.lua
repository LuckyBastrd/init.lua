local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
	capabilities = require("cmp_nvim_lsp").default_capabilities()
end

local servers = {
	bashls = {
		filetypes = { "sh", "sh.tmpl" },
	},
	lua_ls = {
		cmd = { "lua-language-server" },
		settings = {
			Lua = {
				format = {
					enable = true,
					defaultConfig = {
						indent_style = "space",
						indent_size = "2",
					},
				},
			},
		},
	},
	jsonls = {
		-- server_capabilities = {
		-- 	documentFormattingProvider = false,
		-- },
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = {
					enable = false,
					url = "",
				},
				-- schemas = require("schemastore").yaml.schemas(),
			},
		},
	},
	tailwindcss = {
		filetypes = {
			"html",
			"css",
			"scss",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
		},
	},
	sourcekit = {
		manual_install = true,
		cmd = { vim.trim(vim.fn.system("xcrun -f sourcekit-lsp")) },
	},
}

local servers_to_install = vim.tbl_filter(function(key)
	local t = servers[key]
	if type(t) == "table" then
		return not t.manual_install
	else
		return t
	end
end, vim.tbl_keys(servers))

require("mason").setup()
local ensure_installed = {
	"stylua",
	"lua_ls",
	"ts_ls",
}

vim.list_extend(ensure_installed, servers_to_install)
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

-- Set global capabilities for all LSP servers
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- Configure and enable each LSP server
for name, config in pairs(servers) do
	if config == true then
		config = {}
	end

	-- Only call vim.lsp.config if there are server-specific settings
	if next(config) ~= nil then
		-- Remove manual_install flag as it's not an LSP config field
		local lsp_config = vim.tbl_deep_extend("force", {}, config)
		lsp_config.manual_install = nil
		vim.lsp.config(name, lsp_config)
	end

	vim.lsp.enable(name)
end

local disable_semantic_tokens = {
	-- lua = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

		local settings = servers[client.name]
		if type(settings) ~= "table" then
			settings = {}
		end

		local builtin = require("telescope.builtin")

		vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
		-- vim.keymap.set("n", "gd", builtin.lsp_definitions, { buffer = 0 })
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		vim.keymap.set("n", "gr", builtin.lsp_references, { buffer = 0 })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
		vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

		vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
		vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
		vim.keymap.set("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })
		vim.keymap.set("n", "<space>ww", function()
			builtin.diagnostics({ root_dir = true })
		end, { buffer = 0 })

		local filetype = vim.bo[bufnr].filetype
		if disable_semantic_tokens[filetype] then
			client.server_capabilities.semanticTokensProvider = nil
		end

		-- Override server capabilities
		if settings.server_capabilities then
			for k, v in pairs(settings.server_capabilities) do
				if v == vim.NIL then
					---@diagnostic disable-next-line: cast-local-type
					v = nil
				end

				client.server_capabilities[k] = v
			end
		end
	end,
})

-- require("typescript-tools").setup({
-- 	-- on_attach = function(client, buffer_number)
-- 	--   require("twoslash-queries").attach(client, buffer_number)
-- 	-- end,
-- 	settings = {
-- 		-- tsserver_path = "~/.bun/bin/tsgo",
-- 		-- Performance: separate diagnostic server for large projects
-- 		separate_diagnostic_server = true,
-- 		-- When to publish diagnostics
-- 		publish_diagnostic_on = "insert_leave",
-- 		-- JSX auto-closing tags
-- 		jsx_close_tag = {
-- 			enable = true,
-- 			filetypes = { "javascriptreact", "typescriptreact" },
-- 		},
-- 		tsserver_file_preferences = {
-- 			includeInlayParameterNameHints = "all",
-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
-- 			includeInlayVariableTypeHints = true,
-- 			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
-- 			includeInlayPropertyDeclarationTypeHints = true,
-- 			includeInlayFunctionParameterTypeHints = true,
-- 			includeInlayEnumMemberValueHints = true,
-- 			includeInlayFunctionLikeReturnTypeHints = true,
-- 			-- Enable auto imports
-- 			includeCompletionsForModuleExports = true,
-- 			includeCompletionsForImportStatements = true,
-- 		},
--
-- 		tsserver_format_options = {
-- 			insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
-- 			semicolons = "insert",
-- 		},
-- 		complete_function_calls = true,
-- 		include_completions_with_insert_text = true,
-- 		code_lens = "off",
-- 		disable_member_code_lens = true,
-- 		tsserver_max_memory = 12288,
-- 	},
-- })

require("pi.plugins.config.conform")

--- LSP Diagnostic
require("lsp_lines").setup()

vim.keymap.set("", "<leader>l", function()
	local config = vim.diagnostic.config() or {}
	if config.virtual_text then
		vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
	else
		vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
	end
end, { desc = "Toggle lsp_lines" })

local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
	float = { border = "rounded" },
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = signs.Error,
			[vim.diagnostic.severity.WARN] = signs.Warn,
			[vim.diagnostic.severity.HINT] = signs.Hint,
			[vim.diagnostic.severity.INFO] = signs.Info,
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
