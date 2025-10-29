vim.keymap.set(
	"n",
	"<C-k>",
	":lua require('kulala').jump_prev()<CR>",
	{ desc = "Go to prev api call", noremap = true, buffer = true, silent = true }
)

vim.keymap.set(
	"n",
	"<c-j>",
	"<cmd>lua require('kulala').jump_next()<CR>",
	{ noremap = true, silent = true, buffer = true, desc = "Go to next rest" }
)

vim.keymap.set(
	"n",
	"<leader>j",
	"<cmd>lua require('kulala').jump_next()<CR>",
	{ noremap = true, silent = true, buffer = true, desc = "Go to next rest" }
)

vim.keymap.set(
	"n",
	"<c-l>",
	":lua require('kulala').run()<CR>",
	{ noremap = true, silent = true, desc = "Execute current api" }
)
