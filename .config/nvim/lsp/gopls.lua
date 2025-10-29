---@type vim.lsp.Config
return {
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
			analyses = {
				unusedparams = true,
				shadow = true, -- Detects variable shadowing
				nilness = true, -- Detects issues with nil checks
				unusedwrite = true, -- Detects assignments to unused variables
				undeclaredname = true, -- Detects undeclared variables
			},
			-- codelenses = {
			-- 	gc_details = true, -- Display the garbage collector choices
			-- 	generate = true, -- Show the "go generate" lens for generating code
			-- 	regenerate_cgo = true, -- Show the "regenerate cgo" lens
			-- 	tidy = true, -- Show the "go mod tidy" lens
			-- 	upgrade_dependency = true, -- Upgrade dependencies
			-- 	test = true, -- Run tests directly in the editor
			-- },
			staticcheck = true,
			diagnosticsDelay = "500ms", -- Reduces the delay for diagnostics to appear
			hoverKind = "FullDocumentation", -- Can be "SingleLine", "Structured" or "FullDocumentation"
			semanticTokens = true,
		},
	},
}
