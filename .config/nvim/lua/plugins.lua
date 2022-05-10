-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme


local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

local use = require("packer").use

return require("packer").startup({
  function()
    use 'lewis6991/impatient.nvim'

    use 'wbthomason/packer.nvim' -- packer can manage itself

    -- colorschemes
    use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }

    -- file explorer
    use {
      'kyazdani42/nvim-tree.lua',
      config = function()
        require('plugins/nvimTree')
      end
    }

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

    -- treesitter interface
    use {
      'nvim-treesitter/nvim-treesitter', run = 'TSUpdate',
      config = function()
        require('plugins/nvimTreesitter')
      end
    }

    -- surround
    use {
      'tpope/vim-surround'
    }

    -- sneak
    use {
      'justinmk/vim-sneak'
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      event = "BufEnter",
    }

    use {
      "williamboman/nvim-lsp-installer",
      after = "nvim-lspconfig",
      config = function()
        require('plugins/nvimLspInstaller')
      end,
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

    -- statusline
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('lualine').setup { theme = 'gruvbox' }
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

    -- dashboard
    use {
      'goolord/alpha-nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function()
        require('alpha').setup(require 'alpha.themes.startify'.opts)
      end
    }

    -- find
    use {
      'nvim-telescope/telescope.nvim',
      requires = { { 'nvim-lua/plenary.nvim' } },
    }

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
          manual_mode = true, -- 使用 :ProjectRoot
          patterns = { '.git', '.vscode' },
          require('telescope').load_extension('projects')
        }
      end
    }

    -- 复制到系统剪切板
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
