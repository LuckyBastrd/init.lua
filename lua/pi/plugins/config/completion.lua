require("pi.plugins.config.snippets")

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")

local kind_formatter = lspkind.cmp_format({
	mode = "symbol_text",
	menu = {
		buffer = "[buf]",
		nvim_lsp = "[LSP]",
		nvim_lua = "[api]",
		path = "[path]",
		luasnip = "[snip]",
		gh_issues = "[issues]",
	},
})

-- Add tailwindcss-colorizer-cmp as a formatting source
require("tailwindcss-colorizer-cmp").setup({
	color_square_width = 2,
})

local cmp = require("cmp")

cmp.setup({
	sources = {
		{
			name = "lazydev",
			group_index = 0,
		},
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer" },
	},

	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
	},

	-- Enable luasnip to handle snippet expansion for nvim-cmp
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body)
		end,
	},

	formatting = {
		fields = { "icon", "abbr", "menu", "kind" },
		expandable_indicator = true,
		format = function(entry, vim_item)
			local max_width = 37

			-- Lspkind icons
			vim_item = kind_formatter(entry, vim_item)
			vim_item.icon = " " .. (vim_item.icon or "") .. "  "
			vim_item.kind = " (" .. (vim_item.kind or "") .. ") "

			-- Tailwind colorizer
			vim_item = require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)

			-- Truncate long text
			if #vim_item.abbr > max_width then
				vim_item.abbr = string.sub(vim_item.abbr, 1, max_width) .. "…"
			end

			return vim_item
		end,
	},

	sorting = {
		priority_weight = 2,
		comparators = {
			-- Below is the default comparitor list and order for nvim-cmp
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	window = {
		completion = {
			border = "single",
			winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:Pmenusel,Search:None",
			max_height = 10,
			col_offset = -3,
			side_padding = 0,
		},
		documentation = {
			border = "single",
			winhighlight = "Normal:Normal,FloatBorder:Normal",
			maxheight = 10,
			side_padding = 0,
		},
	},
})

cmp.setup.filetype({ "sql" }, {
	sources = {
		{ name = "vim-dadbod-completion" },
		{ name = "buffer" },
	},
})
