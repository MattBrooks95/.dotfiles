-- tip, `:lua vim.print(require('lualine').get_config())` will print the current
-- lualine configuration to the screen, so you can debug why the bar isn't doing
-- what you think it should be doing
require("lualine").setup({
	sections = {
		lualine_c = {
				{'filename',
						path = 1
				}
		},
		lualine_b = {
			'branch',
			'diff',
			{'diagnostics',
				symbols = {
					error = ' ',
					warn = ' ',
					info = ' ',
					hint = ' ',
				},
				always_visible = false,
			}
		}
	}
})
