return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require "cmp"
      opts.mapping["<Tab>"] = cmp.mapping.confirm({ select = true })
    end
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
    config = function()
      require("Comment").setup()
    end,
    event = "User FileOpened",
  }
}
