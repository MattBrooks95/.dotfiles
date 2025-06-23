local setup_dracula = function()
		--get the colors from dracula
		local drac = require('dracula')

		drac.setup({
				overrides = {
						--without this the background of the floating LSP window is the same as the background of the buffer
						--making it hard to read since I don't have borders setup for LSP windows yet
						NormalFloat = { bg = "#4a4d63", fg	= drac.colors().fg }
				},
		})
end

local setup_monokai = function()
		require('monokai').setup({ italics = false })
end

vim.api.nvim_create_autocmd(
		{"ColorScheme"},
		{
				callback =
				-- this is great! You can write Lua functions instead of vim commands
				-- this code imports and sets up the colorscheme when I switch to it
				-- like from telescope or with the :colorscheme command
						function ()
								local cn = vim.g.colors_name
								if cn == "monokai" then
										setup_monokai()
								elseif cn == "dracula" then
										setup_dracula()
								end
						end
		}
)
