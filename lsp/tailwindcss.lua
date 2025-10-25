---@type vim.lsp.Config
return {
	filetypes = { "javascriptreact", "typescriptreact", "astro" },
	autostart = false,
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "classList", "ngClass", "class:list" },
		},
	},
}
