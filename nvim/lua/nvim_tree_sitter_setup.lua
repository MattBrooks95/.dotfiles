require('nvim-treesitter.configs').setup {
	ensure_installed = "maintained",
	sync_install = false,
	ignore_install = {"javascript"},
	highlight = {
		enable = true
	},
}
