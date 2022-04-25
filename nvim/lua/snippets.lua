local ls = require("luasnip")
local s = ls.snippet;
local i = ls.insert_node;
local t = ls.text_node;

--todo why can't I use add_snippets?
ls.snippets = {
	typescript = {
		s("tern", { i(1), t(" ? "), i(2), t(" : "), i(3), t(";") })
	}
}
