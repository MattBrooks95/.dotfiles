-- telescope remaps
-- TODO is there a better way to do this? like run the lua directly?
local telescopeMappings = {
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>" },
	{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>" },
	-- you should remember to use this... it's really helpful
	{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>" },
	-- resume prev telescope search
	{ "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<CR>" },
	-- jump to symbol in file
	{ "<leader>fd", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>" },
	-- list all files shown with 'git status'
	{ "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<CR>" },
	-- find 'all' files listed in git
	{ "<leader>fa", "<cmd>lua require('telescope.builtin').git_files()<CR>" },
	-- picker for colorschemes
	{ "<leader>fc", "<cmd>lua require('telescope.builtin').colorscheme()<CR>" },
	-- picker for showing the color configurations of the different highlight groups
	{ "<leader>fz", "<cmd>lua require('telescope.builtin').highlights()<CR>" },
}

local module = {
		mappings = telescopeMappings
}

return module
