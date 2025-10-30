return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 500 })
			end,
			desc = "Format document",
		},
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports" }, -- "gofumpt"
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "eslint_d" },
			javascriptreact = { "prettierd", "eslint_d" },
			typescriptreact = { "prettierd", "eslint_d" },
			astro = { "prettierd", "prettier" },
			bash = { "beautysh" },
			css = { "prettierd", "prettier" },
			scss = { "prettierd", "prettier" },
			html = { "prettierd", "prettier" },
			http = { "prettierd", "prettier" },
			rest = { "prettierd", "prettier" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			-- yaml = { "prettierd", "prettier" },
			markdown = { "prettierd" },
			graphql = { "prettierd", "prettier" },
			["_"] = { "trim_whitespace", "trim_newlines" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		format_after_save = function()
			-- Stop if we disabled auto-formatting
			if not vim.g.autoformat then
				return nil
			end

			return {
				async = true,
				lsp_format = "fallback",
				timeout_ms = 500,
			}
		end,
	},
	init = function()
		-- Use conform for gq.
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

		-- Start auto-formatting by default (and disable with my ToggleFormat command).
		vim.g.autoformat = true
	end,
	config = function(_, opts)
		local util = require("conform.util")

		-- running eslint fix
		util.add_formatter_args(require("conform.formatters.eslint_d"), { "--fix" })
		require("conform").setup(opts)
	end,
}
