---@type vim.lsp.Config
return {
	root_markers = { "package.json" },
	workspace_required = true,
	settings = {
		complete_function_calls = true,
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			experimental = {
				-- Inlay hint truncation.
				maxInlayHintLength = 30,
				-- For completion performance.
				completion = {
					enableServerSideFuzzyMatch = true,
					entriesLimit = 50,
				},
			},
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			suggest = {
				completeFunctionCalls = true,
				includeCompletionsForModuleExports = true, -- Suggest exports from other modules
				includeAutomaticOptionalChainCompletions = true, -- Auto-complete with optional chaining where applicable
			},
			-- compilerOptions = {
			-- 	strict = true, -- Enable strict type checks
			-- 	strictNullChecks = true, -- Enforce null safety
			-- 	strictPropertyInitialization = true, -- Ensure all properties are initialized
			-- },
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = { enabled = true },
			},
			-- diagnostics = {
			-- 	enable = true,
			-- },
			format = {
				enable = false,
			},
			-- maxTsServerMemory = 4096,
		},
		javascript = {
			suggest = { completeFunctionCalls = true },
			inlayHints = {
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "literals" },
				variableTypes = { enabled = true },
			},
		},
	},
	-- flags = {
	-- 	debounce_text_changes = 100,
	-- },
}
