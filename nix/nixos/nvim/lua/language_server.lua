-- Enable some language servers with the additional completion
-- capabilities offered by nvim-cmp
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- get eslint: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
local servers = {
	'clangd',
	'ts_ls',
	-- 'pyright',
	'ruff',
	'eslint',
	'rust_analyzer',
}

function setup_rescript()
		local rescript_capabilities = vim.lsp.protocol.make_client_capabilities()
		-- THANK YOU dkirchof, I can't link you Rescript forum post about how to set up
		-- file watching because I'm offline
		rescript_capabilities.workspace.didChangeWatchedFiles = {
				dynamicRegistration = true,
		}
	  vim.lsp.config('rescriptls', {
				capabilities = rescript_capabilities,
				cmd = {"npx", "@rescript/language-server", "--stdio" }
		})

		vim.lsp.enable('rescriptls')
end

function setup_python()
		-- vim.lsp.config('pylsp')
		vim.lsp.config('pylsp', {
				settings = {
						pylsp = {
								plugins = {
										-- pylsp_mypy = {
										-- 		live_mode         = false
										-- 		, strict          = false
										-- 		, report_progress = true
										-- }
										autopep8 = {
												enabled = false
										}
								}
						}
				}
		})
		vim.lsp.enable('pylsp')
end

function setup()
		for _, lsp in ipairs(servers) do
			vim.lsp.config(lsp, {
				-- on_attach = my_custom_on_attach,
				capabilities = capabilities
			})
			vim.lsp.enable(lsp)
		end

		setup_rescript()
		setup_python()

		-- need to set some params for the haskell language server
		vim.lsp.config('hls', {
			capabilities = capabilities,
			-- haskell-language-server-wrapper is recommended to be used for nix setups
			settings = {
					haskell = {
							plugin = {
									hlint = {
											diagnosticsOn = false
									}
							}
					}
			},
			cmd = {"haskell-language-server-wrapper", "--lsp"}
		})
		vim.lsp.enable('hls')

		require("format_on_save").setup()

end

local module = {
		servers = servers,
		setup = setup
}

return module
