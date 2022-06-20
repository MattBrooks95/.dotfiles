require('nvim-treesitter.configs').setup {
	ensure_installed = "all",
	sync_install = false,
	ignore_install = {"javascript"},
	highlight = {
		enable = true
	},
}
