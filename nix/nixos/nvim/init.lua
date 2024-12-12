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

setKeyMaps(require("mappings/git").mappings, "n", {})

--color setup needs to occur before 'colorscheme' is set, in order for changes
--to take effect
require("colors_setup")

vim.api.nvim_create_autocmd(
	{"VimEnter"}, {command = "colorscheme dracula"}
);

--blinking cursor
--TODO the curser only starts blinking after leaving insert mode, it does not blink at the start
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

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

-- turn this on to debug LSP
-- vim.lsp.set_log_level('debug');

local language_server = require('language_server')

language_server.setup()

-- telescope remaps
-- TODO is there a better way to do this? like run the lua directly?
local telescopeMappings = require('mappings/telescope')
setKeyMaps(telescopeMappings.mappings, "n", { noremap=true })

--lsp remaps - there were more in the example, but I only
--added in the ones that seemed familiar to me from vs***e
local lspMappings = require('mappings/lsp')
setKeyMaps(lspMappings.mappings, "n", { noremap=true, silent=true })

local treeSitterMappings = require('mappings/treesitter')
setKeyMaps(treeSitterMappings.mappings, "n", { noremap=true, silent=true })

local windowMappings = require('mappings/window')
setKeyMaps(windowMappings.mappings, "n", { noremap=true, silent=true })

local fileOperations = {
		-- save file without needing to type ':'
		{ "<leader>ss", "<cmd>:w<CR>" },
}

setKeyMaps(fileOperations, "n", { noremap=true, silent=true })
