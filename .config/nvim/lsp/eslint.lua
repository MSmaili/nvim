---@type vim.lsp.Config
return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	autostart = true,
	settings = {
		concurrency = "auto",
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = true,
			},
		},
		codeActionOnSave = {
			enable = false,
			mode = "all",
		},
		format = false,
		validate = "on",
	},
	handlers = {
		-- Suppress "No ESLint configuration found" warnings
		["window/showMessageRequest"] = function(_, result)
			return result
		end,
		["eslint/openDoc"] = function(_, params)
			vim.ui.open(params.url)
			return {}
		end,
		["eslint/probeFailed"] = function()
			vim.notify("LSP[eslint]: Probe failed.", vim.log.levels.WARN)
			return {}
		end,
		["eslint/noLibrary"] = function()
			vim.notify("LSP[eslint]: Unable to load ESLint library.", vim.log.levels.WARN)
			return {}
		end,
	},
	on_attach = function(client, _)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
