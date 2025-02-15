local function absolute_path(str)
	return string.sub(str, 1, 1) == "~"
end

local function path_exists(path)
	local handle = io.popen('[ -e "' .. path .. '" ] && echo exists')
	if handle == nil then
		return false
	end
	local result = handle:read("*a")
	handle:close()
	return result:find("exists") ~= nil
end

local function parse_json(content)
	local json = {}
	content = content:gsub("%s+", "")

	for key, value in content:gmatch('"(%w+)":"(.-)"') do
		json[key] = value
	end

	return json
end

local function load_config_cwd()
	-- Use NVIM_CWD first, then fall back to $HOME, then current directory
	local cwd = os.getenv("NVIM_CWD") or os.getenv("HOME") or "."
	local config_path = cwd .. "/sohanscript.json"
	local file = io.open(config_path, "r")
	if file then
		local content = file:read("*a")
		file:close()

		local config = parse_json(content)
		if config and config.cwd then
			local resolved = config.cwd:gsub("%$NVIM_CWD", cwd)
			return resolved
		end
	end
	-- Return proper fallback if needed
	return cwd
end

return {
	entry = function(_, job)
		local args = job.args
		local prefix = "/src"
		local cwd = load_config_cwd()

		for _, path in ipairs(args) do
			if absolute_path(path) then
				return ya.manager_emit("cd", { path })
			end

			local is_exist = path_exists(cwd .. prefix .. path)
			if is_exist then
				ya.manager_emit("cd", { cwd .. prefix .. path })
				return
			end

			is_exist = path_exists(cwd .. path)
			if is_exist then
				ya.manager_emit("cd", { cwd .. path })
				return
			end

			is_exist = path_exists("$NVIM_CWD" .. path)
			if is_exist then
				ya.manager_emit("cd", { "$NVIM_CWD" .. path })
				return
			end
		end

		local content = (args and args[1] or "Unknown path") .. " not found"
		ya.notify({
			title = "No valid path",
			content = content,
			timeout = 3,
		})
	end,
}
