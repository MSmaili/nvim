---@type vim.lsp.Config
return {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = {
				enable = true,
			},
			completion = {
				enabled = true,
				completeKeywords = true, -- Auto-complete keywords in the schema
				completeValues = true, -- Auto-complete values based on enum in schema
			},
			maxItemsComputed = 3000, -- Limits the number of diagnostics for large JSON files
		},
	},
}
