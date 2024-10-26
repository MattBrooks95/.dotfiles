local dracula = require("dracula")

--get the colors from dracula
local colors = require('dracula').colors()

dracula.setup({
		overrides = {
				--without this the background of the floating LSP window is the same as the background of the buffer
				--making it hard to read since I don't have borders setup for LSP windows yet
				NormalFloat = { bg = "#4a4d63", fg	= colors.fg }
		},
})
