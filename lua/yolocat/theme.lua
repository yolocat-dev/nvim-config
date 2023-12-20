local M = {}

M.supportedThemes = {
	'rose-pine',
	'everforest'
}

M.theme = 'rose-pine'
M.transparent = true

M.normalized = function()
	return M.theme:gsub('-', '')
end

M.save = function()
	local file = assert(io.open('/Users/yolocat/.config/nvim/plugin/yolocat_theme.conf', 'w'))
	if(file == nil) then
		print('Failed to open file!')
		return
	end
	file:write(M.theme .. '\n' .. (M.transparent and 'true' or 'false') .. '\n')
end

M.load = function()
	local f = assert(io.open('/Users/yolocat/.config/nvim/plugin/yolocat_theme.conf', 'r'))
	if f == nil then
		M.save()
		return
	end
	M.theme = f:read('l')
	M.transparent = f:read('l') == 'true'
	f:close()
end

local function has_value (tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

vim.api.nvim_create_user_command('Theme', function(opts)
	local args = opts.fargs
	if has_value(M.supportedThemes, args[1]) then
		M.theme = args[1]
		if args[2] == 'true' then
			M.transparent = true
		elseif args[2] == 'false' then
			M.transparent = false
		elseif args[2] ~= nil then
			print('Invalid value for argument 2 (transparent)! Supported values: "true" and "false"')
		end
		M.save()
		Theme()
		LoadLualine()
	else
		print('Theme not supported!')
	end
end, { nargs = '+', complete = 'color' })

return M
