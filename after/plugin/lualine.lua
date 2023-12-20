local custom_mode_map = {
	['n']     = 'NORMAL',
	['no']    = 'O-PEND',
	['nov']   = 'O-PEND',
	['noV']   = 'O-PEND',
	['no\22'] = 'O-PEND',
	['niI']   = 'NORMAL',
	['niR']   = 'NORMAL',
	['niV']   = 'NORMAL',
	['nt']    = 'NORMAL',
	['ntT']   = 'NORMAL',
	['v']     = 'VISUAL',
	['vs']    = 'VISUAL',
	['V']     = 'V-LINE',
	['Vs']    = 'V-LINE',
	['\22']   = 'V-BLCK',
	['\22s']  = 'V-BLCK',
	['s']     = 'SELECT',
	['S']     = 'S-LINE',
	['\19']   = 'S-BLCK',
	['i']     = 'INSERT',
	['ic']    = 'INSERT',
	['ix']    = 'INSERT',
	['R']     = 'REPLCE',
	['Rc']    = 'REPLCE',
	['Rx']    = 'REPLCE',
	['Rv']    = 'V-RPLC',
	['Rvc']   = 'V-RPLC',
	['Rvx']   = 'V-RPLC',
	['c']     = 'COMMND',
	['cv']    = 'EX    ',
	['ce']    = 'EX    ',
	['r']     = 'REPLCE',
	['rm']    = 'MORE  ',
	['r?']    = 'CONFRM',
	['!']     = 'SHELL ',
	['t']     = 'TERMNL'
}

local function custom_get_mode()
	local mode_code = vim.api.nvim_get_mode().mode
	if custom_mode_map[mode_code] == nil then
		return mode_code
	end
	return custom_mode_map[mode_code]
end

function LoadLualine()
	local theme = require('yolocat.theme')

	local custom_theme = require('lualine.themes.' .. theme.theme)

	if theme.transparent then
		custom_theme.normal.c.bg = 'none'
		custom_theme.insert.c.bg = 'none'
		custom_theme.replace.c.bg = 'none'
		custom_theme.visual.c.bg = 'none'
		custom_theme.command.c.bg = 'none'
		custom_theme.inactive.c.bg = 'none'
	end

	vim.opt.showmode = false

	require('lualine').setup({
		options = {
			theme = custom_theme,
			disabled_filetypes = {
				undotree_2 = {},
				diffpanel_3 = {},
				undotree = {},
				diffpanel = {}
			},
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' }
		},
		sections = {
			lualine_a = { custom_get_mode }
		}
	})
end

LoadLualine()
