---@type NvPluginSpec[]
local plugins = {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require("custom.configs.null-ls")
        end,
      },
      {
        "williamboman/mason.nvim",
        config = function(_, opts)
          dofile(vim.g.base46_cache .. "mason")
          require("mason").setup(opts)
          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
          end, {})
          require("custom.configs.lspconfig") -- Load in lsp config
        end,
      },
      "williamboman/mason-lspconfig.nvim"
    },
    -- config = function() end, -- Override to setup mason-lspconfig
  },

  {
    "ahmedkhalf/project.nvim",
    cmd = "ProjectRoot",
    config = function()
      require("project_nvim").setup {
        manual_mode = true, -- 使用 :ProjectRoot
        patterns = { ".git", ".vscode" },
      }
    end,
  },

  -- {
  --   "ojroques/vim-oscyank",
  --   lazy = false,
  -- },

  {
    "justinmk/vim-sneak",
    lazy = false,
  },

  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function(_, opts)
      require("nvim-surround").setup(opts)
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    event = "User FileOpened",
  },
}

return plugins
