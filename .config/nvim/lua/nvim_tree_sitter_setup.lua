-- tree sitter needs read/write access to the parser install directory to work
-- which means that it will fail when neovim is installed to the nix store
-- so it is necessary to specify an alternative directory
-- https://github.com/NixOS/nixpkgs/issues/189838

-- Defines a read-write directory for treesitters in nvim's cache dir
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
-- Prevents reinstall of treesitter plugins every boot
vim.opt.runtimepath:append(parser_install_dir)

-- I'm not sure what's going on, but nvim-treesitter's `main` branch (the branch
-- still being developed) causes an error in the Telescope preview
-- telescope v0.2.0 removes the hard requirement for nvim-treesitter, so I've removed
-- the configuration here. The error has gone away. I'm not sure how to replace this config
-- I guess I need to do :h vim.treesitter and do the below configuration using Nvim's API
-- local nvim_treesitter = require('nvim-treesitter').install {
-- 		"haskell", "javascript", "typescript", "lua", "c", "rust",
-- 		"python", "elixir"
-- }
-- 
-- require('nvim-treesitter').setup {
-- 	--ensure_installed = {
-- 	--		"haskell",
-- 	--		"javascript",
-- 	--		"typescript",
-- 	--		-- broken grammar, causes errors when I open a rescript file
-- 	--		-- "rescript",
-- 	--		"lua",
-- 	--		"c",
-- 	--		"rust",
-- 	--		"ocaml",
-- 	--		"python",
-- 	--		"elixir"
-- 	--},
-- 	sync_install = false,
-- 	-- ignore_install = {"javascript"},
-- 	highlight = {
-- 		enable = true
-- 	},
-- 	-- specify the install dir for the parser files that need to be mutable
-- 	parser_install_dir = parser_install_dir
-- }
