-- `shiftwidth` returns `tabstop` value when `shiftwidth` is 0
-- I'd rather use tabs but the official formatter uses spaces, and until there's an alternative formatter that's what I should do
vim.bo.expandtab = true
vim.bo.shiftwidth = 0
vim.bo.tabstop = 2

vim.treesitter.start()
