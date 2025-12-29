-- Enable some language servers with the additional completion
-- capabilities offered by nvim-cmp
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- get eslint: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
local servers = {
	'clangd',
	'ts_ls',
	'pyright',
	'ruff',
	'eslint',
	'rust_analyzer',
}

function setup()
		for _, lsp in ipairs(servers) do
			vim.lsp.config(lsp, {
				-- on_attach = my_custom_on_attach,
				capabilities = capabilities
			})
			vim.lsp.enable(lsp)
		end

	  vim.lsp.config('rescriptls', {
				capabilities = capabilities,
				cmd = {"npx", "@rescript/language-server", "--stdio" }
		})

		vim.lsp.enable('rescriptls')

		-- need to set some params for the haskell language server
		vim.lsp.config('hls', {
			capabilities = capabilities,
			cmd = {"haskell-language-server", "--lsp"}
		})
		vim.lsp.enable('hls')
end

local module = {
		servers = servers,
		setup = setup
}

return module
