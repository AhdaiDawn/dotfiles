-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local cmd = vim.cmd
cmd [[packadd packer.nvim]]

local packer = require 'packer'

-- Add packages
return packer.startup(function()
  use 'wbthomason/packer.nvim' -- packer can manage itself

  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
  }
  require('plugins/nvim-tree')

  -- indent line
  use {
    'lukas-reineke/indent-blankline.nvim',
  }
  require('plugins/indent-blankline')

  -- This plugin show trailing whitespace.
  use {
    "ntpeters/vim-better-whitespace",
  }

  -- autopair
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  -- icons
  use 'kyazdani42/nvim-web-devicons'

  -- tagviewer
  use {
    'liuchengxu/vista.vim',
  }
  require('plugins/vista')

  -- treesitter interface
  use {
    'nvim-treesitter/nvim-treesitter',run = 'TSUpdate'
  }
  require('plugins/nvim-treesitter')

  -- surround
  use {
    'tpope/vim-surround'
  }

  -- sneak
  use {
    'justinmk/vim-sneak'
  }

  -- colorschemes
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- LSP
  use {
    'neovim/nvim-lspconfig',
  }
  require('plugins/nvim-lspconfig')

  -- autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip', -- 片段
      'rafamadriz/friendly-snippets', -- vscode片段
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip',
    }
  }
  require('plugins/nvim-cmp')
  require('plugins/snippets')

  -- statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('lualine').setup { theme = 'gruvbox'}
    end
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Git support for nvim.
  use {
    "tpope/vim-fugitive",
  }

  -- dashboard
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.opts)
    end
  }

  -- find
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
  }

  -- format
  use {
    'sbdchd/neoformat',
  }

  -- Comment
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  -- project manager
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {
        manual_mode = true,  -- 使用 :ProjectRoot
        patterns = {'.git','.vscode'},
        require('telescope').load_extension('projects')
      }
    end
  }

end)
