return {
	{
		"shortcuts/no-neck-pain.nvim",
		version = "*",
		cmd = { "NoNeckPain" },
		keys = {
			{ "<leader>uz", "<cmd>NoNeckPain<cr>", desc = "Toggle center-screen" },
			{
				"<leader>uZ",
				function()
					local nnp = require("no-neck-pain")
					local ok = pcall(nnp.toggleScratchPad)
					if not ok then
						nnp.toggle()
						vim.defer_fn(function() -- Introduce a 100ms delay before running the second command
							nnp.toggleScratchPad()
						end, 100)
					end
				end,
				desc = "Toggle notes for center screen (Toggles center if not enabled)",
			},
		},
		opts = {
			width = 120,
			buffers = {
				scratchPad = {
					enabled = false,
					fileName = "notes",
					location = "~/",
				},
				bo = {
					filetype = "md",
				},
			},
		},
	},
}
