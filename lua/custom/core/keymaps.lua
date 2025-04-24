local M = {}

local keymap = vim.api.nvim_set_keymap
--
------------------------------
-- LEADER KEY
------------------------------
keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
keymap("", "<C-z>", "<Nop>", { noremap = true, silent = true }) -- turn off ctrl-z
vim.g.mapleader = " "
vim.g.maplocalleader = " "

------------------------------
-- Mappings
------------------------------
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
M.keyMaps = {
	-------------------------------------
	-- Normal Mode
	-------------------------------------
	n = {
		------------------------------
		-- Window
		------------------------------
		["<C-h>"] = "<C-w>h",
		["<C-j>"] = "<C-w>j",
		["<C-k>"] = "<C-w>k",
		["<C-l>"] = "<C-w>l",

		-- Close
		["<leader>qq"] = { ":q<CR>", desc = "Quit window" },
		["<leader>qQ"] = { ":qa!<CR>", desc = "Quit vim & do not save" },

		------------------------------
		-- UI
		------------------------------
		-- Toggle spellchker
		["<leader>us"] = { ":setlocal spell!<CR>", desc = "Toggle spellchker" },

		-- Toggle pastemode
		["<leader>up"] = { ":setlocal paste!<CR>", desc = "Toggle paste mode" },

		------------------------------
		-- Resize splits with arrows
		------------------------------
		["<C-Up>"] = ":resize -2<CR>",
		["<C-Down>"] = ":resize +2<CR>",
		["<C-Left>"] = ":vertical resize -2<CR>",
		["<C-Right>"] = ":vertical resize +2<CR>",

		------------------------------
		-- Buffers
		------------------------------
		-- Navigate
		["<S-l>"] = ":bnext<CR>",
		["<S-h>"] = ":bprevious<CR>",

		-- Save
		["<leader>w"] = ":w<CR>",

		-- Close
		["<leader>cm"] = ":Mason<CR>",
		-- ["<leader>C"] = ":bdelete!<CR>",

		-- SUDO save
		-- ["<leader>W"] = ":w !sudo -S tee % <CR>",

		------------------------------
		-- Open neo tree
		------------------------------
		-- ["<leader>e"] = ":NvimTreeToggle<CR>",

		------------------------------
		-- Text
		------------------------------
		-- Move text up/down
		["<A-j>"] = ":m .+1<CR>==",
		["<A-k>"] = ":m .-2<CR>==",

		-- Move half screen up/down and center
		["<C-d>"] = "<C-d>zz",
		["<C-u>"] = "<C-u>zz",

		-- Disable highlight
		["<leader>h"] = ":nohl<CR>",

		-- GIT UNDO TREE
		["<leader>gu"] = { ":UndotreeToggle<CR>", desc = "Toggle undotree" },

		------------------------------
		-- Plugin manager
		------------------------------
		["<leader>l"] = { "<cmd>Lazy<cr>", desc = "Toggle lazyVim" },
	},

	-------------------------------------
	-- Visual Mode
	-------------------------------------
	v = {
		------------------------------
		-- Text
		------------------------------
		-- Move text up/down
		["<A-j>"] = ":m '>+1<CR>gv=gv",
		["<A-k>"] = ":m '<-2<CR>gv=gv",

		-- Stay on indent
		["<"] = "<gv",
		[">"] = ">gv",

		-- Visual mode pressing # searches for the current selection
		["#"] = '"fy/\\V<C-R>f<CR>',
	},

	-------------------------------------
	-- Visual Block Mode
	-------------------------------------
	x = {
		------------------------------
		-- Text
		------------------------------
		-- Move text up/down
		["<A-j>"] = ":m '>+1<CR>gv-gv",
		["<A-k>"] = ":m '<-2<CR>gv-gv",
		["p"] = [[p:if v:register == '"'<Bar>let @@=@0<Bar>endif<CR>]],
	},

	-------------------------------------
	-- Terminal Mode
	-------------------------------------
	t = {
		-- Terminal window navigation
		["<C-h>"] = "<C-\\><C-N><C-w>h",
		["<C-j>"] = "<C-\\><C-N><C-w>j",
		["<C-k>"] = "<C-\\><C-N><C-w>k",
		["<C-l>"] = "<C-\\><C-N><C-w>l",
	},

	-------------------------------------
	-- Command Mode
	-------------------------------------
	c = {
		-- Bash like keys
		["<C-A>"] = "<Home>",
		["<C-E>"] = "<END>",
		["<C-K>"] = "<C-U>",
		["<C-P>"] = "<Up>",
		["<C-N>"] = "<Down>",
	},
}

------------------------------
-- Set keymaps
------------------------------
custom.set_keymappings(M.keyMaps)

vim.keymap.set("n", "k", function()
	return vim.v.count > 0 and "m'" .. vim.v.count .. "k" or "gk"
end, { expr = true })

vim.keymap.set("n", "j", function()
	return vim.v.count > 0 and "m'" .. vim.v.count .. "j" or "gj"
end, { expr = true })
