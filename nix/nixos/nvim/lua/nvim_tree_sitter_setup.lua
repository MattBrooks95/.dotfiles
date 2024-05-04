-- tree sitter needs read/write access to the parser install directory to work
-- which means that it will fail when neovim is installed to the nix store
-- so it is necessary to specify an alternative directory
-- https://github.com/NixOS/nixpkgs/issues/189838

-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
-- Prevents reinstall of treesitter plugins every boot
vim.opt.runtimepath:append(parser_install_dir)

-- the tree sitter parsers require a bunch of c++ header files
-- so it was necessary to specify 'clang++' as the compiler instead
-- of just clang
-- I actually ended up needing to use gcc, because clang was failing for the Julia parser (which I won't even use...)
-- something about clang++ not being able to handle mixed c/c++ files and c initialization lists
require('nvim-treesitter.install').compilers = { 'gcc' }

require('nvim-treesitter.configs').setup {
	ensure_installed = "all",
	sync_install = false,
	ignore_install = {"javascript"},
	highlight = {
		enable = true
	},
	-- specify the install dir for the parser files that need to be mutable
	parser_install_dir = parser_install_dir
}
