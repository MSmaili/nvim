local M = {}

local settings_file = vim.fn.stdpath("data") .. "/custom_settings.json"

local function read_file()
	local ok, content = pcall(vim.fn.readfile, settings_file)
	if not ok or #content == 0 then
		return {}
	end
	local success, data = pcall(vim.json.decode, table.concat(content))
	return success and data or {}
end

local function write_file(data)
	pcall(vim.fn.writefile, { vim.json.encode(data) }, settings_file)
end

function M.load(key, defaults)
	local data = read_file()
	return data[key] or defaults or {}
end

function M.save(key, value)
	local data = read_file()
	data[key] = value
	write_file(data)
end

return M
