return {
	{
		keys = {
			{ "<leader>K", "<cmd>lua require('kubectl').toggle()<cr>", desc = "Open kubectl" },
		},
		"ramilito/kubectl.nvim",
		version = "2.*",
		dependencies = "saghen/blink.download",
		config = function()
			require("kubectl").setup()
		end,
	},
}
