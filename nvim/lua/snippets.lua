local ls = require("luasnip")
local s = ls.snippet;
local i = ls.insert_node;
local t = ls.text_node;

--ls.add_snippets("all", {
--	s("test", { t("please work") })
--});

ls.add_snippets("typescript", {
	s("tern", { i(1), t(" ? "), i(2), t(" : "), i(3), t(";") }),
	s("comm", {
		t({ "/**", "* "}),
		i(1),
		t({ "", "**/"}),
	}),
	s("desc", {
		t("describe(\""), i(1) , t("\", ("), i(2), t(") => {"),
		t({ "", "\t" }), i(3),
		t({ "", "});" }),
	}),
	s("prom", {
		t("new Promise((resolve, reject) => {"),
		t({ "", "\t" }), i(1),
		t({ "", "});" }),
	}),
	s("ttable", {
		t("test.each("), i(1), t(")(\""), i(2), t("\", ("), i(3), t(") => {"),
		t({ "", "\t"}), i(4),
		t({ "", "});" }),
	}),
	s("redc", {
		t(".reduce<"), i(1), t(">(("), i(2), t(", "), i(3), t(") => {"),
		t({ "", "\t"}), i(4),
		t({ "", "});"}),
	}),
	s("impr", {
		t("import React from \"react\";")
	}),
	s("tstest", {
		t("test(\""), i(1), t("\", ("), i(2), t(") => {"),
		t({"", "\t"}), i(3),
		t({"", "});"}),
	}),
	s("reactc", {
		t("const "), i(1), t(": React.FC"), i(2), t(" = ("), i(3), t(") => {"),
		t({"", "\t"}), t("return ("),
		t({"", "\t);"}),
		t({"", "}"}),
		t({"", "export default "}), i(4), t(";")
	})
});

--still looking for a clean way to write snippets that have empty lines
ls.add_snippets("svelte", {
	s("comp", {
		t({ "<script>", "</script>", "", "" }),
		i(1),
		t({ "", "", "<style>", "</style>" })
	})
});
