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

call plug#end()

nnoremap <C-p> :Files<CR>

"setup theme
autocmd vimenter * ++nested colorscheme gruvbox

"blinking cursor
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

set runtimepath ^=~/.vim runtimepath +=~/.vim/after
let &packpath = &runtimepath


" nvm cmp setup
lua <<EOF
local luasnip = require('luasnip')
local cmp = require('cmp')
local lspkind = require("lspkind")
lspkind.init({
	symbol_map = {
		Text = "",
		Method = "",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = ""
	}
})

cmp.setup({
	completion = {
		completeopt = 'menu,menuone,noinsert',
	},
	-- REQUIRED a snippet engine is necessary for auto completion
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		--idk if I want or need these yet
--		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
--		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
--		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
--		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--		['<C-e>'] = cmp.mapping({
--			i = cmp.mapping.abort(),
--			c = cmp.mapping.close(),
--		}
		['<Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end,
		['<CR>'] = cmp.mapping.confirm({ select = true });
	},
	sources = {
		{ name = "nvim_lsp" },
		-- do I need this?
		{ name = "luasnip" },
		--{ name = "buffer", keyword_length = 3 },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end
	},
	formatting = {
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				--buffer = "[buf]",
				nvm_lsp = "[nvm_lsp]",
				luasnip = "[luasnip]",
			},
		}
	},
	--experimental = {
	--	ghost_text = true,
	--}
})
EOF

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
