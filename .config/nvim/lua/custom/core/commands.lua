local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local smailiGroup = augroup("smaili", { clear = true })

-- Highlight on yank
autocmd("TextYankPost", {
	group = smailiGroup,
	desc = "Highlight text on yank",
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("BufReadPost", {
	group = smailiGroup,
	desc = "Go to the last cursor position when opening buffer",
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- Enable fenced code highlighting for markdown
vim.g.markdown_fenced_languages = { "html", "javascript", "typescript", "vim", "lua", "css" }

-- Clear NeoCodeium suggestions when CMP menu opens
autocmd("User", {
	group = smailiGroup,
	pattern = "BlinkCmpMenuOpen",
	desc = "Clear NeoCodeium when CMP menu opens",
	callback = function()
		local ok, neocodeium = pcall(require, "neocodeium")
		if ok then
			neocodeium.clear()
		end
	end,
})

-- Disable auto-commenting on newline
autocmd("FileType", {
	pattern = "*",
	group = smailiGroup,
	desc = "Disable auto comment on new lines",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- Set colorscheme on startup
autocmd("VimEnter", {
	group = smailiGroup,
	desc = "Set custom colorscheme",
	callback = function()
		Custom.theme.apply(Custom.colorscheme.name)
	end,
})

-- User commands for theme management
vim.api.nvim_create_user_command("ToggleTransparency", Custom.theme.toggle_transparency, {
	desc = "Toggle colorscheme transparency",
})

vim.api.nvim_create_user_command("ThemeStatus", function()
	local settings_file = vim.fn.stdpath("data") .. "/custom_settings.json"
	local saved = Custom.state.load("theme", {})

	local lines = {
		"Theme Status:",
		"",
		"Current (in-memory):",
		"  Name: " .. Custom.colorscheme.name,
		"  Transparent: " .. tostring(Custom.colorscheme.transparent),
		"",
		"Saved (on disk):",
		"  Name: " .. (saved.name or "none"),
		"  Transparent: " .. tostring(saved.transparent),
		"",
		"Settings file: " .. settings_file,
	}

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
end, {
	desc = "Show theme status and settings",
})

-- open help in vertical split
autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
autocmd("VimResized", {
	command = "wincmd =",
})

-- Rename file with lsp support nvim-tree
local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
autocmd("User", {
	pattern = "NvimTreeSetup",
	callback = function()
		local events = require("nvim-tree.api").events
		events.subscribe(events.Event.NodeRenamed, function(data)
			if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
				data = data
				Snacks.rename.on_rename_file(data.old_name, data.new_name)
			end
		end)
	end,
})
