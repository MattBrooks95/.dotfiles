--"line numbers
vim.opt.relativenumber = true
vim.opt.number = true

--stop writing lines that are so long
vim.opt.colorcolumn = {80, 120}

-- wrapping defaults to off for sanity
-- for filetypes where you want wrapping, set this to true using ftplungin
vim.opt.wrap = false

--tabbing and white space
--use editorConfig to set this on a per-project basis
--use the filetype plugin to override this for specific file types, like Haskell or Python, which unfortunately require spaces
vim.opt.expandtab = false
vim.opt.list = false
vim.opt.listchars = { space="␣", tab="⏟⏟" }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- TODO I'm not sure this setting is working
--turn off the mouse because bumping your touchpad sucks
vim.opt.mouse = ""

--indenting
vim.opt.autoindent = true
vim.opt.smartindent = true

--theming
vim.opt.bg = "dark"
vim.opt.showcmd = true

--searching
--ignore case turns off case sensitivity for searching
vim.opt.ignorecase = true
--"smartcase should only be case sensitive if the whole string is capsed, like
--"MY_MAGIC_NUMBER, BUT you also need to set ignorecase!
vim.opt.smartcase = true
--set smartcase
--do not show the highlighted results of the previous search
vim.opt.hlsearch = false
--letters are highlighted as you type
vim.opt.incsearch = true

--thank you Primeagen
--ensure that there are always some lines above and below the curser
vim.opt.scrolloff = 8

-- explicitly set this to 'none', I think I ony want window borders on LSP stuff
vim.o.winborder = 'none'
