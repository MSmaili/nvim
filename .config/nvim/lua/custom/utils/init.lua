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

local themePersistFile = vim.fn.stdpath("data") .. "/colorscheme.txt"

-- Read persisted theme or return fallback
function Custom.get_colorscheme(fallback)
	local ok, lines = pcall(vim.fn.readfile, themePersistFile)
	if ok and #lines > 0 then
		return lines[1]
	end
	return fallback or "default"
end

-- Apply colorscheme with fallback
function Custom.apply_colorscheme(theme)
	vim.opt.termguicolors = true

	local ok = pcall(vim.cmd.colorscheme, theme)
	if not ok then
		-- If it fails, just use default
		pcall(vim.cmd.colorscheme, "default")
		return "default"
	end

	vim.cmd("redraw!")

	-- Update plugins that need it
	vim.schedule(function()
		local ok_lualine, lualine = pcall(require, "lualine")
		if ok_lualine then
			lualine.setup(require("custom.plugins.lualine").opts())
		end

		-- Set custom highlights after colorscheme loads
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceRead" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite" })
	end)

	return theme
end

-- Save and apply colorscheme
function Custom.save_colorscheme(theme)
	local applied = Custom.apply_colorscheme(theme)
	pcall(vim.fn.writefile, { applied }, themePersistFile)
	vim.notify("Colorscheme: " .. applied, vim.log.levels.INFO)
end
