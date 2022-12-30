return {
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup {
        manual_mode = true, -- 使用 :ProjectRoot
        patterns = { ".git", ".vscode" },
      }
    end,
  },

  -- 复制到系统剪切板
  ["ojroques/vim-oscyank"] = {
    disable = false,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["jose-elias-alvarez/null-ls.nvim"] = {
    config = function()
      require "custom.plugins.nullls"
    end,
    requires = { "nvim-lua/plenary.nvim" },
  },

  ["justinmk/vim-sneak"] = {},

  ["kylechui/nvim-surround"] = {},

  ["goolord/alpha-nvim"] = {
    after = "base46",
    disable = false,
    requires = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
  },
}
