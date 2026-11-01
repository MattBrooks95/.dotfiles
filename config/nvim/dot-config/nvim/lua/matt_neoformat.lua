function set_try_node()
		vim.g.neoformat_try_node_exe = 1
end

format_group = vim.api.nvim_create_augroup("format", { clear = true });

-- the typescript LSP uses a formatter that isn't Prettier
-- so for typescript, use neoformat instead of vim.lsp.buf.format
function setup_format_on_save()
		vim.api.nvim_create_autocmd({ 'LspAttach' }, {
				group = vim.api.nvim_create_augroup("lsp_attach", { clear = true })
				, callback = function(ev)
						-- I thought the { clear = true } setting when creating the augroup
						-- automatically removes previously registered handlers but it
						-- doesn't seem to
						vim.api.nvim_clear_autocmds { group = format_group }
						vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = ev.buf
								, group = format_group
								, callback = function()
										-- use the buffer id to get the buffer file type
										local buffer_type = vim.bo["filetype"]
										-- only call neoformat for typescript and typescript react
										if buffer_type == "typescript" or buffer_type == "typescriptreact" then
												-- I wonder if it's possible to write a lua API for
												-- neoformat instead of doing it the old way
												vim.cmd("Neoformat")
										end
								end
						})
				end
		})
end


local module = {
		set_try_node = set_try_node
		, setup_format_on_save = setup_format_on_save
}

return module
