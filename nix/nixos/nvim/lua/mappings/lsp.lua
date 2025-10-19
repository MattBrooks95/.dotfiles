local mappings = {
	{ 'n', '<leader>lh',  function() vim.lsp.buf.hover({ border = 'rounded' }) end },
	{ 'n', '<leader>ldc', function() vim.lsp.buf.declaration({ border = 'rounded' }) end },
	{ 'n', '<leader>ldf', function() vim.lsp.buf.definition({ border = 'rounded' }) end },
	{ 'n', '<leader>lr',  function() vim.lsp.buf.references() end },
	{ 'n', '<leader>li',  function() vim.lsp.buf.implementation({ border = 'rounded' }) end },
	{ 'n', '<leader>lnm', function() vim.lsp.buf.rename() end },
	{ 'n', '<leader>la',  function() vim.lsp.buf.code_action() end },
	{ 'n', '<leader>le',  function() vim.diagnostic.open_float({ border = 'rounded' }) end },
}


local do_setup = function()
		for _, mapping in ipairs(mappings) do
				vim.keymap.set(mapping[1], mapping[2], mapping[3])
		end
end

local module = {
	do_setup = do_setup
}

return module
