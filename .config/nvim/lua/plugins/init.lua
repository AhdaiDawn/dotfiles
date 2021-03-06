-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

local fn = vim.fn

-- Install packer.nvim if it's not installed.
local packer_bootstrap
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  print "Cloning packer ..."
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })

  vim.cmd "packadd packer.nvim"
end

local use = require("packer").use

require("packer").startup({
  function()
    use 'nvim-lua/plenary.nvim'
    use 'lewis6991/impatient.nvim'
    use 'wbthomason/packer.nvim' -- packer can manage itself

    -- colorschemes
    use {
      "ellisonleao/gruvbox.nvim",
      config = function()
        vim.cmd("colorscheme gruvbox")
        vim.o.background = "dark"
      end,
    }

    use 'kyazdani42/nvim-web-devicons' -- icons

    -- statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup { theme = 'gruvbox' }
      end
    }

    -- file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      ft = "alpha",
      config = function()
        require('plugins/nvimTree')
      end
    }

    use({
      "akinsho/toggleterm.nvim",
      keys = "<C-t>",
      cmd = "ToggleTerm",
      config = function()
        require("plugins/toggleterm")
      end,
    })

    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require('plugins/indentBlankline')
      end
    }

    -- treesitter interface
    use {
      "nvim-treesitter/nvim-treesitter",
      run = 'TSUpdate',
      event = { "BufRead", "BufNewFile" },
      config = function()
        require('plugins/nvimTreesitter')
      end
    }

    -- git labels
    use {
      'lewis6991/gitsigns.nvim',
      opt = true,
      config = function()
        require('gitsigns').setup()
      end
    }

    -- autopair
    use {
      'windwp/nvim-autopairs',
      config = function()
        require('nvim-autopairs').setup()
      end
    }

    -- surround
    use 'tpope/vim-surround'

    -- sneak
    use 'justinmk/vim-sneak'

    use {
      "williamboman/nvim-lsp-installer",
    }
    use {
      "neovim/nvim-lspconfig",
      after = "nvim-lsp-installer",
      config = function()
        require('plugins/nvimLsp')
      end
    }

    -- autocomplete
    use({
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
    })
    use({
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
        require("plugins/nvimCmp")
      end,
    })
    use({
      "hrsh7th/cmp-buffer",
      after = "nvim-cmp",
    })
    use({
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
    })
    use({
      "hrsh7th/cmp-nvim-lsp",
      after = "nvim-lsp-installer",
    })
    use({
      "L3MON4D3/LuaSnip",
      after = "nvim-cmp",
      config = function()
        require("luasnip/loaders/from_vscode").load()
      end,
    })
    use({
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
    })
    -- TODO: Lazyload this on just lua filetype.
    use({
      "hrsh7th/cmp-nvim-lua",
      after = "nvim-cmp",
    })

    -- dashboard
    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('alpha').setup(require 'alpha.themes.startify'.opts)
      end
    }

    -- find
    use { 'nvim-telescope/telescope.nvim' }

    -- Comment
    use {
      'numToStr/Comment.nvim',
      event = "BufRead",
      config = function()
        require('Comment').setup()
      end
    }
    -- project manager
    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("project_nvim").setup {
          manual_mode = true, -- ?????? :ProjectRoot
          patterns = { '.git', '.vscode' },
          require('telescope').load_extension('projects')
        }
      end
    }

    -- This plugin show trailing whitespace.
    use 'ntpeters/vim-better-whitespace'

    -- ????????????????????????
    use "ojroques/vim-oscyank"

    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
