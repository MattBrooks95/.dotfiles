local windowMappings = {
		-- open a window from a horizontal split (split horizontally so that the windows are stacked vertically)
		{ "<leader>ws", "<cmd>:split<CR>" },
		-- open a window from a vertical split
		{ "<leader>wv", "<cmd>:vsplit<CR>" },
		-- close all windows except for the window that the cursor is in
		{ "<leader>wo", "<cmd>:only<CR>" },
		-- close the currently selected window
		{ "<leader>wc", "<cmd>:close<CR>" },

		-- use wincmd to alias cursor window movements, to avoid needing to type CTRL-w
		-- it's so nice
		{ "<leader>wj", "<cmd>:wincmd j<CR>" },
		{ "<leader>wk", "<cmd>:wincmd k<CR>" },
		{ "<leader>wh", "<cmd>:wincmd h<CR>" },
		{ "<leader>wl", "<cmd>:wincmd l<CR>" },

		--TODO move these to a file windowMappings.lua
		--TODO add in a binding to jump to window by number, and make lualine show the window number
}

local module = {
		mappings = windowMappings
}

return module
