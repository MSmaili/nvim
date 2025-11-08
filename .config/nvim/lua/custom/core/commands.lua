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

-- Set colorscheme on startup
autocmd("VimEnter", {
	group = smailiGroup,
	desc = "Set custom colorscheme",
	callback = function()
		local ok, err = pcall(function()
			vim.cmd.colorscheme(Custom.get_colorscheme(Custom.colorscheme.name))
		end)
		if not ok then
			vim.notify("Failed to load colorscheme: " .. err, vim.log.levels.WARN)
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

--- auto update the highlight style on colorscheme change
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "LspReferenceText" })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "LspReferenceRead" })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite" })
	end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
	command = "wincmd =",
})

-- Rename file with lsp support nvim-tree
local prev = { new_name = "", old_name = "" } -- Prevents duplicate events
vim.api.nvim_create_autocmd("User", {
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
