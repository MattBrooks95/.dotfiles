require('lib');

vim.g.mapleader = " "

require("sets")


--for showing which lines have been changed in git, which lines have errors
--TODO how does this setting relate to LSP gutter messages and git gutter messages
vim.opt.signcolumn = "yes"

--" GIT 
--" this appends the vim fugitive status to the status line in the bottom
--" of the screen
vim.opt.statusline = "%<%f\\ %{FugitiveStatusline()} hex:%B dec:%b %h%m%r%=%-14.(%l,%c%V%)\\ %P"

setKeyMaps(require("git_mappings"), "n", {})

--TODO this is the cheating way of porting something from viml to lua
vim.cmd([[
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
]])

--color setup needs to occur before 'colorscheme' is set, in order for changes
--to take effect
require("colors_setup")

--"setup theme
--" autocmd vimenter * ++nested colorscheme gruvbox
--TODO Neovim 7.0+ has an api to do autocmds in lua
--vim.api.nvim_exec("autocmd vimenter * ++nested colorscheme everforest", {});
vim.api.nvim_create_autocmd(
	{"VimEnter"}, {command = "colorscheme dracula"}
);

--blinking cursor
--TODO the curser only starts blinking after leaving insert mode, it does not blink at the start
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

--TODO when I did the init.vim -> init.lua conversion, it seems like I don't need this
--set runtimepath ^=~/.vim runtimepath +=~/.vim/after
--vim.opt.runtimepath ="~/.vim runtimepath +=~/.vim/after"
--let &packpath = &runtimepath


--TODO use pcall to make not finding these scripts not stop execution of this init file
--lua snippets
require("snippets")
--snippet completion that allows for jumping to the next snippet mode
--poached from tjdevries, of course
--keymap.set syntax requires neovim 0.7.0
--TODO deduplicate the require, make this reusable, look for more useful keymaps
vim.keymap.set("i", "<c-k>", function()
	if require('luasnip').expand_or_jumpable() then
		require('luasnip').expand_or_jump()
	end
end, { silent = true })

--nvm cmp setup
require("nvim_cmp_setup")
--telescope setup
require("nvim_telescope_setup")
--tree sitter setup
require("nvim_tree_sitter_setup")

-- lualine status bar
require("lualine_setup")

--" clangd for C++, tsserver for typescript
--" I copied this from https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
--" I have no idea what is going on

-- Add additional capabilities supported by nvim-cmp
local nvm_cmp = require('cmp_nvim_lsp')
local capabilities = nvm_cmp.default_capabilities()

-- Enable some language servers with the additional completion
-- capabilities offered by nvim-cmp
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
-- get eslint: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#eslint
local servers = {
	'clangd',
	'tsserver',
	'pylsp',
	'eslint',
	-- 'svelte', -- npm install -g svelte-language-server
	-- 'elmls',
	'rust_analyzer',
	'rescriptls'
}

local lspConfig = require('lspconfig')

for _, lsp in ipairs(servers) do
	lspConfig[lsp].setup {
		-- on_attach = my_custom_on_attach,
		capabilities = capabilities,
	}
end

-- turn this on to debug LSP
-- vim.lsp.set_log_level('debug');

-- need to set some params for the haskell language server
lspConfig['hls'].setup {
	capabilities = capabilities,
	cmd = {"haskell-language-server", "--lsp"}
}

-- telescope remaps
-- TODO is there a better way to do this? like run the lua directly?
local telescopeMappings = {
	{ "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<CR>" },
	{ "<leader>fg", "<cmd>lua require('telescope.builtin').live_grep()<CR>" },
	{ "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<CR>" },
	{ "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<CR>" },
	-- resume prev telescope search
	{ "<leader>fr", "<cmd>lua require('telescope.builtin').resume()<CR>" },
	-- jump to symbol in file
	{ "<leader>fd", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>" },
	-- list all files shown with 'git status'
	{ "<leader>fs", "<cmd>lua require('telescope.builtin').git_status()<CR>" },
	-- find 'all' files listed in git
	{ "<leader>fa", "<cmd>lua require('telescope.builtin').git_files()<CR>" }
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
	{ "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
	{ "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>" }
}

setKeyMaps(lspMappings, "n", { noremap=true, silent=true })

local treeSitterMappings = {
	-- to stop tree sitter ('x' for off)
	{ "<leader>tx", "<cmd>lua vim.treesitter.stop()<CR>" },
	-- to start tree sitter ('o' for o)
	{ "<leader>to", "<cmd>lua vim.treesitter.start()<CR>"},
	-- inspect tree
	{ "<leader>ti", "<cmd>lua vim.treesitter.inspect_tree()<CR>"}
}

setKeyMaps(treeSitterMappings, "n", { noremap=true, silent=true })

-- window mappings
local windowMappings = {
		-- open a window from a horizontal split (split horizontally so that the windows are stacked vertically)
		{ "<leader>ws", "<cmd>:split<CR>" },
		-- open a window from a vertical split
		{ "<leader>wv", "<cmd>:vsplit<CR>" },
		-- close all windows except for the window that the cursor is in
		{ "<leader>wo", "<cmd>:only<CR>" },
		-- close the currently selected window
		{ "<leader>wc", "<cmd>:close<CR>" },

		-- use wincmd to alias cursor window movements, to avoid needing to type CTRL-w
		-- it's so nice
		{ "<leader>wj", "<cmd>:wincmd j<CR>" },
		{ "<leader>wk", "<cmd>:wincmd k<CR>" },
		{ "<leader>wh", "<cmd>:wincmd h<CR>" },
		{ "<leader>wl", "<cmd>:wincmd l<CR>" },

		--TODO move these to a file windowMappings.lua
		--TODO add in a binding to jump to window by number, and make lualine show the window number
}

setKeyMaps(windowMappings, "n", { noremap=true, silent=true })

local fileOperations = {
		-- save file without needing to type ':'
		{ "<leader>ss", "<cmd>:w<CR>" },
}

setKeyMaps(fileOperations, "n", { noremap=true, silent=true })
