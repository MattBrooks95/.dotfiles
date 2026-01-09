-- https://github.com/nvim-treesitter/nvim-treesitter/blob/9177f2ff061627f0af0f994e3a3c620a84c0c59b/plugin/filetypes.lua#L4
--

vim.treesitter.language.register("typescript", "ts")
vim.treesitter.language.register("tsx", { "typescriptreact", "typescript.tsx" })

vim.treesitter.start()

--[[
There are two places where the syntax could be being set to the empty string. I think the typescript and javascript treesitter highlights aren't covering some things that the normal vim syntax does.
```syntax.vim
" Set up the connection between FileType and Syntax autocommands.
" This makes the syntax automatically set when the file type is detected
" unless treesitter highlighting is enabled.
" Avoid an error when 'verbose' is set and <amatch> expansion fails.
augroup syntaxset
  au! FileType *	if !exists('b:ts_highlight') | 0verbose exe "set syntax=" . expand("<amatch>") | endif
  augroup END
```

Theres another lua file in the treesitter lua code in the neovim repo that sets it to the empty string as well.
filetype.lua:152
It looks kinda like this:
```filetype.lua
vim.bo[self.bufnr].syntax = ""
```

when I run `:set syntax=typescript` in neovim, the highlights work again.

Setting the syntax again here is probably a hack or bandaid over something else I've misconfigured in the neovim-flake repository.
]]

vim.bo.syntax = "typescript";
