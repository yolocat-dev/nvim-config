require("mason").setup()

local lsp = require('lsp-zero')

lsp.preset('recommended')

lsp.ensure_installed({
	'eslint',
	'rust_analyzer',
	'gopls',
	'lua_ls',
	'clangd',
	'asm_lsp',
	'tailwindcss',
	'vimls'
})

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()

local cmp_select = {behavior = cmp.SelectBehavior.Select}

lsp.set_preferences({
	sign_icons = { }
})

cmp.setup({
	sources = {
		{name = 'copilot'},
		{name = 'nvim_lsp'},
		{name = 'path'},
		{name = 'luasnip'},
		{name = 'nvim_lua'},
		{name = 'buffer'},
	},
	formatting = cmp_format,
	mapping = cmp.mapping.preset.insert({
		['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
		['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
		['<Enter>'] = cmp.mapping.confirm({ select = false }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<Tab>'] = function(fallback) fallback() end,
		['<S-Tab>'] = function(fallback) fallback() end,
	})
})

--lsp.setup_nvim_cmp({
--	mapping = cmp_mappings
--})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', '?', function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set('n', '<leader>ws', function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set('n', '<leader>d', function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set('n', 'öd', function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set('n', 'äd', function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set('n', '<leader>rr', function() vim.lsp.buf.references() end, opts)
	vim.keymap.set('n', '<leader>rn', function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set('n', '<leader>fd', function() vim.lsp.buf.format() end, opts)
end)

lsp.setup()

require'yolocat.lsp'.ConfigureDefaults();
