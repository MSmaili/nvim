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
}

-- Set key-map by table
-- Give a table with modes as keys for example:
-- map = {n = {[keymap]='function or what you want your keymap to execute', desc="for description"}}
function Custom.set_keymappings(keymaps)
	local default_options = {
		n = {
			noremap = true,
			silent = true,
		},
		t = {
			silent = true,
		},
	}

	-- Map through the keys
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

local persist = vim.fn.stdpath("data") .. "/colorscheme.txt"

-- read the file, return the first line or fallback to default  theme
function Custom.get_colorscheme(fallback)
	local ok, lines = pcall(vim.fn.readfile, persist)
	if ok and #lines > 0 then
		return lines[1]
	end
	return fallback or "default"
end

-- write the theme to disk and apply it
function Custom.save_colorscheme(theme)
	vim.cmd("colorscheme " .. theme)
	pcall(vim.fn.writefile, { theme }, persist)
	vim.notify("Colorscheme saved: " .. theme, vim.log.levels.INFO)

	local ok, lualine = pcall(require, "lualine")
	if ok then
		lualine.setup(require("custom.plugins.lualine").opts())
	end
end
