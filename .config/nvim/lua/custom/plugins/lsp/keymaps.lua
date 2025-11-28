-- Toggle virtual_text
local virtual_text_enabled = Custom.lsp.diagnostic.virtual_text_enabled
local virtual_line_enabled = Custom.lsp.diagnostic.virtual_line_enabled

function ToggleVirtualText()
	virtual_text_enabled = not virtual_text_enabled
	vim.diagnostic.config({
		virtual_text = virtual_text_enabled,
	})
	print("Virtual Text: " .. (virtual_text_enabled and "On" or "Off"))
end

function ToggleVirtualLines()
	virtual_line_enabled = not virtual_line_enabled
	vim.diagnostic.config({
		virtual_lines = virtual_line_enabled,
	})
	print("Virtual line: " .. (virtual_line_enabled and "On" or "Off"))
end

return function(bufnr)
	local keymaps = {
		n = {
			------------------------------
			-- LSP
			------------------------------
			-- ["<leader>cr"] = { vim.lsp.buf.rename, desc = "Rename", buffer = bufnr },
			-- ["<leader>ca"] = { vim.lsp.buf.code_action, desc = "Action", buffer = bufnr },
			["<leader>cS"] = { "<cmd>FzfLua lsp_document_symbols<CR>", desc = "Document Symbols" },
			["<leader>ci"] = { "<cmd>FzfLua lsp_incoming_calls<CR>", desc = "List incoming calls (FZF)" },
			["<leader>cd"] = { vim.diagnostic.open_float, desc = "Show diagnostics", buffer = bufnr },
			------------------------------
			-- Hover
			------------------------------
			["K"] = { vim.lsp.buf.hover, desc = "Hover Documentation", buffer = bufnr },

			------------------------------
			-- Workspace
			------------------------------
			["<leader>cwa"] = { vim.lsp.buf.add_workspace_folder, desc = "Workspace Add Folder", buffer = bufnr },
			["<leader>cwr"] = { vim.lsp.buf.remove_workspace_folder, desc = "Workspace Remove Folder" },
			["<leader>cwd"] = { ":FzfLua diagnostics_workspace<CR>", desc = "Workspace diagnostics", buffer = bufnr },

			------------------------------
			-- LSP
			------------------------------
			["gd"] = { ":FzfLua lsp_definitions<CR>", desc = "Peek definition", buffer = bufnr },
			["gt"] = { ":FzfLua lsp_typedefs<CR>", desc = "Peek definition", buffer = bufnr },
			["grr"] = { ":FzfLua lsp_references<CR>", desc = "Go to refrences" },
			["gra"] = {
				function()
					require("fzf-lua").lsp_code_actions({
						winopts = {
							relative = "cursor",
							width = 0.4,
							height = 0.4,
							row = 1,
							preview = { horizontal = "up:70%" },
						},
						multiprocess = true,
					})
				end,
				desc = "Code action",
				buffer = bufnr,
			},
			["gD"] = {
				function()
					require("fzf-lua").lsp_definitions({ jump1 = true })
				end,
				desc = "[G]oto [D]eclaration",
				buffer = bufnr,
			},
			["gI"] = { ":FzfLua lsp_implementations<CR>", desc = "[G]oto [I]mplementation", buffer = bufnr },
			["<leader>uvt"] = { ":lua ToggleVirtualText()<CR>", desc = "Toggle Virtual Text", buffer = bufnr },
			["<leader>uvl"] = { ":lua ToggleVirtualLines()<CR>", desc = "Toggle Virtual Text", buffer = bufnr },
		},
	}

	Custom.set_keymappings(keymaps)
end
