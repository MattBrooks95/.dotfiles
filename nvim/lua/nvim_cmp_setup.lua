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
		['<CR>'] = cmp.mapping.confirm({ select = false });
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		--{ name = "buffer", keyword_length = 3 },
	}, {
		--{ name = "buffer" }
	}),
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
