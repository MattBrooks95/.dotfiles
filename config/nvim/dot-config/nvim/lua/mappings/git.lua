local mappings = {
	{ "<leader>gs", ":G<CR>" },
	{ "<leader>gc", ":G commit<CR>" },
	{ "<leader>gp", ":G push<CR>" },
	{ "<leader>gd", ":G diff<CR>" },
	{ "<leader>gb", ":G blame<CR>" },
	{ "<leader>gl", ":G log --graph<CR>" },
}

local module = {
		mappings = mappings
}

return module
