Custom = {
	colorscheme = {
		transparent = true,
		name = "catppuccin",
	},
	explorer = {},
	lsp = {
		diagnostic = {
			virtual_text_enabled = true,
			virtual_line_enabled = false,
		},
	},
	state = require("custom.state"),
	theme = require("custom.utils.theme"),
}

-- Load saved theme settings
local saved = Custom.state.load("theme", Custom.colorscheme)
Custom.colorscheme.name = saved.name
Custom.colorscheme.transparent = saved.transparent

-- Set key-map by table
function Custom.set_keymappings(keymaps)
	local default_options = {
		n = { noremap = true, silent = true },
		t = { silent = true },
	}

	for vimMode, keyMaps in pairs(keymaps) do
		local base_options = default_options[vimMode] or default_options["n"]

		for keyMap, commandOrTable in pairs(keyMaps) do
			local command = commandOrTable

			if type(commandOrTable) == "table" then
				command = commandOrTable[1]
				base_options = vim.tbl_extend("force", base_options, commandOrTable)
				base_options[1] = nil
			end

			vim.keymap.set(vimMode, keyMap, command, base_options)
		end
	end
end
