local lspMappings = {
	{ "<leader>ldc", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
	{ "<leader>ldf", "<cmd>lua vim.lsp.buf.definition()<CR>" },
	{ "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>" },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>" },
	{ "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
	{ "<leader>lnm", "<cmd>lua vim.lsp.buf.rename()<CR>" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
	{ "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>" }
}

local module = {
		mappings = lspMappings
}

return module
