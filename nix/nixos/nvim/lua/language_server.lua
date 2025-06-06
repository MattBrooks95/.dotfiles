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
	'rescriptls'
}

local lspConfig = require('lspconfig')

function setup()
		for _, lsp in ipairs(servers) do
			lspConfig[lsp].setup {
				-- on_attach = my_custom_on_attach,
				capabilities = capabilities,
			}
		end

		-- need to set some params for the haskell language server
		lspConfig['hls'].setup {
			capabilities = capabilities,
			cmd = {"haskell-language-server", "--lsp"}
		}
end

local module = {
		servers = servers,
		setup = setup
}

return module
