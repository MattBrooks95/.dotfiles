vim.bo.expandtab = true
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4
vim.wo.list = true

-- as of tree sitter 2025-12-21 latest commit, I needed to either do this in the ftplugin
-- files for each language, OR set up an autocommand. I think doing it in ftplugin
-- for the languages I use is the most straightforward.
vim.treesitter.start()
