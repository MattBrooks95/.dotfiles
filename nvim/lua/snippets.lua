local ls = require("luasnip")
local s = ls.snippet;
local i = ls.insert_node;
local t = ls.text_node;

--ls.add_snippets("all", {
--	s("test", { t("please work") })
--});

ls.add_snippets("typescript", {
	s("tern", { i(1), t(" ? "), i(2), t(" : "), i(3), t(";") })
});

ls.add_snippets("svelte", {
	s("comp", {
		t("<script>"),
		t("</script>"),
		t(""),
		t(""),
		t("<style>"),
		t("</style>")
	})
});
