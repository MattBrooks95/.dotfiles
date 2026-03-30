-- https://www.mitchellhanberg.com/modern-format-on-save-in-neovim/
function setup()
		vim.api.nvim_create_autocmd({ 'LspAttach' }, {
				group = vim.api.nvim_create_augroup("lsp", { clear = true })
				, callback = function(ev)
						vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = ev.buf
								-- this being cleared hasn't been tested yet because typescript
								-- uses Prettier through neoformat instead of LSP
								, group = vim.api.nvim_create_augroup("lsp-format", { clear = true })
								, callback = function()
										-- use the buffer id to get the buffer file type
										local buffer_type = vim.bo["filetype"]
										-- don't call lsp format for typescript files because if no
										-- formatters are configured
										-- (we're using Prettier instead of typescript language server)
										-- it will cause a warning
										if buffer_type ~= "typescript" and buffer_type ~= "typescriptreact" then
												vim.lsp.buf.format {
														async = false
														, id = ev.data.client_id
												}
										end
								end
						})
				end
		})
end

-- exclude LSPs that we don't want to run the LSP formatting for
-- Namely, this is Typescript since a lot of projects run Prettier instead
-- https://neovim.io/doc/user/lsp/#vim.lsp.buf.format%28%29 <- I want to not call 'format' entirely
-- instead of calling it and then using the filter to do nothing for typescript files
-- because if no formatters are available the format command causes a warning to happen on file save
-- function format_filter(client)
-- 		return client.name ~= "ts_ls"
-- end

local module = {
		setup = setup
}

return module
