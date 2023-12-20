vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'rose-pine/neovim',
		as = 'rose-pine'
	}

	use {
		'neanias/everforest-nvim',
		config = function()
			require('everforest').setup({ background = 'hard' })
		end
	}

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-treesitter/playground')

	use('theprimeagen/harpoon')

	use('mbbill/undotree')

	use('tpope/vim-fugitive')

	use('zbirenbaum/copilot.lua')
	use {
		'zbirenbaum/copilot-cmp',
		after = { "copilot.lua" },
		config = function ()
			require("copilot_cmp").setup()
		end
	}

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},

			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}

	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons'
		}
	}

	use('windwp/nvim-ts-autotag')
	use('windwp/nvim-autopairs')

	use('lewis6991/gitsigns.nvim')

	use {
		'nvim-lualine/lualine.nvim',
		after = {'rose-pine', 'everforest-nvim'}
	}

	use {
        'andrewferrier/wrapping.nvim',
        config = function()
            require('wrapping').setup()
        end,
    }

	use 'christoomey/vim-tmux-navigator'
end)
