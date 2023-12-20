local rosepine = require('rose-pine.palette')
local everforest = require('everforest.colours').generate_palette({
	colours_override = function() end,
	background = 'hard'
}, 'dark')

local colorMap = {
	rosepine = {
		GitAdd = rosepine.foam,
		GitChange = rosepine.rose,
		GitDelete = rosepine.love,
		Telescope = rosepine.gold,
	},
	everforest = {
		GitAdd = everforest.green,
		GitChange = everforest.yellow,
		GitDelete = everforest.red,
		Telescope = everforest.aqua
	}
}

function RemoveBg(remove, map)
	if map == nil then
		map = {}
	end

	if remove then
		map.bg = 'none'
	end

	return map
end

function TableMerge(t1, t2)
	for k, v in pairs(t2) do
		if type(v) == "table" then
			if type(t1[k] or false) == "table" then
				TableMerge(t1[k] or {}, t2[k] or {})
			else
				t1[k] = v
			end
		else
			t1[k] = v
		end
	end
	return t1
end

function SetHl(group, map)
	local current = vim.api.nvim_get_hl(0, { name = group })
	vim.api.nvim_set_hl(0, group, TableMerge(current, map))
end

require('yolocat.theme').load()

function Theme(color)
	color = color or require('yolocat.theme')

	vim.cmd.colorscheme(color.theme)

	local theme = colorMap[color.normalized()]

	local r = color.transparent

	SetHl('Normal', RemoveBg(r))
	SetHl('NormalFloat', RemoveBg(r))

	SetHl('SignColumn', RemoveBg(r))
	SetHl('GitSignsAdd', RemoveBg(r, { fg = theme.GitAdd }))
	SetHl('GitSignsChange', RemoveBg(r, { fg = theme.GitChange }))
	SetHl('GitSignsDelete', RemoveBg(r, { fg = theme.GitDelete }))

	SetHl('FloatBorder', RemoveBg(r))
	SetHl('StatusLine', RemoveBg(r))
	SetHl('StatusLineNC', RemoveBg(r))
	SetHl('NormalNC', RemoveBg(r))

	SetHl('TelescopeBorder', RemoveBg(r))
	SetHl('TelescopeNormal', RemoveBg(r))
	SetHl('TelescopePromptNormal', RemoveBg(r))
	SetHl('TelescopeSelection', RemoveBg(r))
	SetHl('TelescopeTitle', RemoveBg(r, { fg = theme.Telescope }))
	SetHl('TelescopeSelectionCaret', RemoveBg(r, { fg = theme.Telescope }))

	SetHl('VertSplit', RemoveBg(r))

	SetHl('NvimTreeNormal', RemoveBg(r))
	SetHl('NeoTreeNormal', RemoveBg(r))
	SetHl('NvimTreeEndOfBuffer', RemoveBg(r))
	SetHl('NeoTreeEndOfBuffer', RemoveBg(r))

	SetHl('MatchParen', RemoveBg(r))

	vim.o.cursorline = true
	vim.o.cursorlineopt = 'number'
	if r then
		vim.cmd [[highlight CursorLineNr guibg=none guifg=none]]
	end
end

Theme()
