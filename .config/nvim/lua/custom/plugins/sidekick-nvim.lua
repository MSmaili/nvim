return {
	"folke/sidekick.nvim",
	opts = {
		nes = { enabled = false },
		cli = {
			mux = {
				backend = "tmux",
				enabled = true,
			},
			tools = {
				amazon_q = { cmd = { "kiro-cli" } },
			},
		},
		prompts = {
			picker = "fzf-lua",
		},
	},
	keys = {
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
				-- require("sidekick.cli").toggle()
			end,
			desc = "Sidekick Toggle CLI (amazon_q)",
		},
		{
			"<leader>ah",
			function()
				require("sidekick.cli").hide()
			end,
			desc = "Hide the cli Session",
		},
		{
			"<leader>ad",
			function()
				require("sidekick.cli").close()
			end,
			desc = "Detach a CLI Session",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
	},
}
