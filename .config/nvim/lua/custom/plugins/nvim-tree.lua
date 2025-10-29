local o = vim.o

local function float_cfg()
	local h = math.floor((o.lines - o.cmdheight) * 0.8)
	local w = math.floor(o.columns * 0.4)

	return {
		relative = "editor",
		border = "rounded",
		width = w,
		height = h,
		row = math.floor((o.lines - o.cmdheight - h) / 2),
		col = math.floor((o.columns - w) / 2),
	}
end

return {
	"nvim-tree/nvim-tree.lua",
	opts = {
		disable_netrw = true,
		hijack_netrw = true,
		update_cwd = true,
		view = {
			relativenumber = true,
			float = {
				enable = true,
				open_win_config = float_cfg,
			},
			width = function()
				return math.floor(vim.opt.columns:get() * 0.3)
			end,
		},
		renderer = {
			highlight_opened_files = "all",
			highlight_modified = "all",

			icons = {
				git_placement = "after",
				modified_placement = "after",
			},
		},
		update_focused_file = {
			enable = true,
			debounce_delay = 15,
			update_root = false,
			ignore_list = {},
		},
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		filters = {
			dotfiles = false,
		},
	},
	keys = {
		{ "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle tree" },
	},
}
