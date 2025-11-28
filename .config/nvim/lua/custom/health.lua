local M = {}

function M.check()
	vim.health.start("Custom Configuration")

	-- Check settings file
	local settings_file = vim.fn.stdpath("data") .. "/custom_settings.json"
	if vim.fn.filereadable(settings_file) == 1 then
		vim.health.ok("Settings file exists: " .. settings_file)

		local ok, content = pcall(vim.fn.readfile, settings_file)
		if ok and #content > 0 then
			local success, data = pcall(vim.json.decode, table.concat(content))
			if success then
				vim.health.ok("Settings file is valid JSON")
			else
				vim.health.error("Settings file contains invalid JSON")
			end
		end
	else
		vim.health.warn("Settings file does not exist (will be created on first save)")
	end

	-- Check current theme
	local theme = Custom.colorscheme.name
	local theme_loaded = pcall(vim.cmd.colorscheme, theme)
	if theme_loaded then
		vim.health.ok("Current theme '" .. theme .. "' is installed")
	else
		vim.health.error("Current theme '" .. theme .. "' is not installed")
	end

	-- Check state consistency
	local saved = Custom.state.load("theme", {})
	if saved.name == Custom.colorscheme.name and saved.transparent == Custom.colorscheme.transparent then
		vim.health.ok("In-memory state matches saved state")
	else
		vim.health.warn("In-memory state differs from saved state (will sync on next save)")
	end
end

return M
