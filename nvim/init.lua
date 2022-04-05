vim.g.mapleader = " "

--"line numbers
vim.opt.relativenumber = true
vim.opt.number = true

--stop writing lines that are so long
vim.opt.colorcolumn = {80, 120}

--sanity
vim.opt.wrap = false

--tabbing and white space
--TODO you will need to figure out a way to dynamically switch between
--spaces and tabs based on the project you're in.
vim.opt.expandtab = false
vim.opt.list = false
vim.opt.listchars = { space="␣", tab="⏟⏟" }
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

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
--for showing which lines have been changed in git, which lines have errors
--TODO how does this setting relate to LSP gutter messages and git gutter messages
vim.opt.signcolumn = "yes"

--" GIT 
--" this appends the vim fugitive status to the status line in the bottom
--" of the screen
vim.opt.statusline = "%f\\ %{FugitiveStatusline()}"

--set keymaps in a loop
function setKeyMaps(gitMappings, mode, options)
	for _, gitMapping in ipairs(gitMappings) do 
		vim.api.nvim_set_keymap(
			mode,
			gitMapping[1],
			gitMapping[2],
			options
		)
	end
end

local gitMappings = {
	{ "<leader>gs", ":G<CR>" },
	{ "<leader>gc", ":G commit<CR>" },
	{ "<leader>gp", ":G push<CR>" },
	{ "<leader>gd", ":G diff<CR>" },
	{ "<leader>gb", ":G blame<CR>" },
}

setKeyMaps(gitMappings, "n", {})

--TODO this is the cheating way of porting something from viml to lua
vim.cmd([[
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]])

--TODO this is the cheating way of porting something from viml to lua
vim.cmd([[
call plug#begin('~/.config/nvim/plugged')
"fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"theme
"Plug 'morhetz/gruvbox'
Plug 'sainnhe/everforest'
"Collection of configurations for built-in LSP client
Plug 'neovim/nvim-lspconfig'
" allows customization of nvm cmp menu
Plug 'onsails/lspkind-nvim'

"completion####################################
"https://github.com/neovim/nvim-lspconfig/wiki/Snippets
"autocompletion plugin
Plug 'hrsh7th/nvim-cmp'
"LSP source for nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
" buffer source
Plug 'hrsh7th/cmp-buffer'
"snippets source for nvim-cmp
Plug 'saadparwaiz1/cmp_luasnip'
"snippets plugin
Plug 'L3MON4D3/LuaSnip'
"completion####################################

" telescope
" a native sorter was recommended for better performance
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" git
Plug 'tpope/vim-fugitive'
" tree-sitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
]])
--
--"setup theme
--" autocmd vimenter * ++nested colorscheme gruvbox
--TODO Neovim 7.0+ has an api to do autocmds in lua
vim.api.nvim_exec("autocmd vimenter * ++nested colorscheme everforest", {});

--blinking cursor
--TODO the curser only starts blinking after leaving insert mode, it does not blink at the start
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

--TODO when I did the init.vim -> init.lua conversion, it seems like I don't need this
--set runtimepath ^=~/.vim runtimepath +=~/.vim/after
--vim.opt.runtimepath ="~/.vim runtimepath +=~/.vim/after"
--let &packpath = &runtimepath


--TODO use pcall to make not finding these scripts not stop execution of this init file
--nvm cmp setup
require("nvim_cmp_setup")
--telescope setup
require("nvim_telescope_setup")
--tree sitter setup
require("nvim_tree_sitter_setup")

--" clangd for C++, tsserver for typescript
--" I copied this from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
--" I have no idea what is going on

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion
-- capabilities offered by nvim-cmp
--local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
local servers = { 'clangd', 'tsserver', 'pylsp', 'hls' }
for _, lsp in ipairs(servers) do
	require('lspconfig')[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	}
end

-- telescope remaps
-- TODO is there a better way to do this? like run the lua directly?
local telescopeMappings = {
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<cr>" },
	{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>" },
	{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>" },
	{ "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<cr>" },
	{ "<leader>fd", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>" },
	{ "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<cr>" }
}
setKeyMaps(telescopeMappings, "n", { noremap=true })

--lsp remaps - there were more in the example, but I only
--added in the ones that seemed familiar to me from vs***e
local lspMappings = {
	{ "<leader>ldc", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
	{ "<leader>ldf", "<cmd>lua vim.lsp.buf.definition()<CR>" },
	{ "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>" },
	{ "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>" },
	{ "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
	{ "<leader>lnm", "<cmd>lua vim.lsp.buf.rename()<CR>" },
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>" }
}
-- fuck

setKeyMaps(lspMappings, "n", { noremap=true, silent=true })
