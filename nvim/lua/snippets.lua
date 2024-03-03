local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local f = ls.function_node

--ls.add_snippets("all", {
--	s("test", { t("please work") })
--});

-- Not sure how to declare lambdas inline, this just gets the string
-- from the first text node mentioned in the call to function_node
function getNodeText(arg_nodes)
	return arg_nodes[1][1]
end


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
	s("tstest", {
		t("test(\""), i(1), t("\", ("), i(2), t(") => {"),
		t({"", "\t"}), i(3),
		t({"", "});"}),
	}),
});

-- the component name is written in between the const declaration and the
-- component type, and the prop type name is also written into two places,
-- next to the function parameter and into the React.FC type declaration
-- example output, with component name "MyComponent" and prop type name "MyProps"
--import React from "react";
--
--const MyComponent: React.FC<MyProps> = (props: MyProps) => {
--	return (
--	);
--}
--export default MyComponent;
ls.add_snippets("typescriptreact", {
	s("reactc", {
		t("import React from \"react\";"),
		t({"", "", "const "}), i(1), t(": React.FC<"), i(2), t("> = (props: "), f(getNodeText, {2}), i(3), t(") => {"),
		t({"", "\t"}), t("return ("),
		t({"", "\t);"}),
		t({"", "}"}),
		t({"", "export default "}), f(getNodeText, {1}), t(";")
	})
})

--still looking for a clean way to write snippets that have empty lines
ls.add_snippets("svelte", {
	s("comp", {
		t({ "<script>", "</script>", "", "" }),
		i(1),
		t({ "", "", "<style>", "</style>" })
	})
});
