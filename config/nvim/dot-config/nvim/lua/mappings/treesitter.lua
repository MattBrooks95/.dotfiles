local treeSitterMappings = {
	-- to stop tree sitter ('x' for off)
	{ "<leader>tx", "<cmd>lua vim.treesitter.stop()<CR>" },
	-- to start tree sitter ('o' for o)
	{ "<leader>to", "<cmd>lua vim.treesitter.start()<CR>"},
	-- inspect tree
	{ "<leader>ti", "<cmd>lua vim.treesitter.inspect_tree()<CR>"}
}

local module = {
		mappings = treeSitterMappings
}

return module
