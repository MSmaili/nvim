return {
	"ThePrimeagen/refactoring.nvim",
	keys = {
		{
      "<leader>rr",
      ":lua require('refactoring').select_refactor()<CR>",
      desc = "Select refactoring",
      mode = "v",
    },
		-- Refactoring operations
		{
			"<leader>re",
			"<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>",
			desc = "Extract Function",
			mode = "v",
		},
		{
			"<leader>rf",
			"<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>",
			desc = "Extract Function To File",
			mode = "v",
		},
		{
			"<leader>rv",
			"<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>",
			desc = "Extract Variable",
			mode = "v",
		},
		{
			"<leader>ri",
			"<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>",
			desc = "Inline Variable",
			mode = "v",
		},
		-- Extract block
		{
			"<leader>rbb",
			"<Cmd>lua require('refactoring').refactor('Extract Block')<CR>",
			desc = "Extract Block",
			mode = "n",
		},
		{
			"<leader>rbf",
			"<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>",
			desc = "Extract Block To File",
			mode = "n",
		},
	},
}
