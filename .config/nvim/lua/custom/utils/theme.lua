local M = {}

local function save_config()
	Custom.state.save("theme", Custom.colorscheme)
end

local function apply_transparency()
	if not Custom.colorscheme.transparent then
		return
	end
	local highlights =
		{ "Normal", "NormalFloat", "SignColumn", "NormalNC", "Folded", "NonText", "SpecialKey", "VertSplit" }
	for _, hl in ipairs(highlights) do
		vim.api.nvim_set_hl(0, hl, { bg = "NONE" })
	end
end

function M.apply(theme, transparent)
	vim.opt.termguicolors = true

	Custom.colorscheme.name = theme
	if transparent ~= nil then
		Custom.colorscheme.transparent = transparent
	end

	pcall(vim.cmd.colorscheme, theme)
	apply_transparency()
	save_config()

	vim.schedule(function()
		local ok, lualine = pcall(require, "lualine")
		if ok then
			lualine.setup(require("custom.plugins.lualine").opts())
		end

		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText", underline = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceRead", underline = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite", underline = true })
	end)

	vim.notify(string.format("Theme: %s (%s)", theme, Custom.colorscheme.transparent and "transparent" or "opaque"))
end

function M.toggle_transparency()
	M.apply(Custom.colorscheme.name, not Custom.colorscheme.transparent)
end

return M
