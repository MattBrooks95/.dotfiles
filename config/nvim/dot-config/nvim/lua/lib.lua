function setKeyMaps(mappings, mode, options)
	for _, gitMapping in ipairs(mappings) do 
		vim.api.nvim_set_keymap(
			mode,
			gitMapping[1],
			gitMapping[2],
			options
		)
	end
end
