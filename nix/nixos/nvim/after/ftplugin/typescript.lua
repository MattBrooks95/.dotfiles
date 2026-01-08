-- https://github.com/nvim-treesitter/nvim-treesitter/blob/9177f2ff061627f0af0f994e3a3c620a84c0c59b/plugin/filetypes.lua#L4

vim.treesitter.language.register("typescript", "ts")
vim.treesitter.language.register("tsx", { "typescriptreact", "typescript.tsx" })

vim.treesitter.start()
