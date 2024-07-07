function setKeyMaps(gitMappings, mode, options)
	for _, gitMapping in ipairs(gitMappings) do 
		vim.api.nvim_set_keymap(
			mode,
			gitMapping[1],
			gitMapping[2],
			options
		)
	end
end
