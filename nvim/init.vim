let mapleader=" "

"line numbers
set relativenumber
set number

"stop writing lines that are so long
set colorcolumn=80,120

"sanity
set nowrap

"tabbing and white space
set tabstop=4
set shiftwidth=4
set nolist
set listchars+=space:␣,tab:⏟⏟

"theming
set bg=dark
set showcmd

"searching
"ignore case turns off case sensitivity for searching
set ignorecase
"smartcase should only be case sensitive if the whole string is capsed, like
"MY_MAGIC_NUMBER, BUT you also need to set ignorecase!
set smartcase
set nohlsearch
"letters are highlighted as you type
set incsearch

" thank you Primeagen
" ensure that there are always some lines above and below the curser
set scrolloff=8
" for showing which lines have been changed in git, which lines have errors
set signcolumn=yes

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
"fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
"theme
Plug 'morhetz/gruvbox'
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
call plug#end()

"setup theme
autocmd vimenter * ++nested colorscheme gruvbox

"blinking cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

set runtimepath ^=~/.vim runtimepath +=~/.vim/after
let &packpath = &runtimepath


" nvm cmp setup
luafile ~/.config/nvim/nvim_cmp_setup.lua
" telescope setup
luafile ~/.config/nvim/nvim_telescope_setup.lua

" clangd for C++, tsserver for typescript
" I copied this from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
" I have no idea what is going on
lua << EOF
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable some language servers with the additional completion
-- capabilities offered by nvim-cmp
--local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
local servers = { 'clangd', 'tsserver' }
for _, lsp in ipairs(servers) do
	require('lspconfig')[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	}
end
EOF

" remaps
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>