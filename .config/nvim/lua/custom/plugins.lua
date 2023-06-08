local plugins = {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
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
