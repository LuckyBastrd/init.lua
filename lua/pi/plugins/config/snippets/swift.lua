require("luasnip.session.snippet_collection").clear_snippets("elixir")

local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("swift", {
    -- stylua: ignore start
	s("pr", fmt('print("{}"){}', { i(1), i(0) })),
    s("vi", fmt([[
        struct {}: View {{
            var body: some View {{
                {}
            }}
        }}

        #Preview {{
            {}()
        }}
    ]],
    {
        i(1, "ContentView"),
        i(0, "Text(\"Hello, World!\")"),
        rep(1)
    })),
	-- stylua: ignore end
})
