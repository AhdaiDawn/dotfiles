return {
  ["ahmedkhalf/project.nvim"] = {
    config = function()
      require("project_nvim").setup {
        manual_mode = true, -- 使用 :ProjectRoot
        patterns = { '.git', '.vscode' },
      }
    end
  },

  -- 复制到系统剪切板
  ["ojroques/vim-oscyank"] = {
    disable = false,
  },

  ["neovim/nvim-lspconfig"] = {
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end
  },

  ["justinmk/vim-sneak"] = {},

  ["kylechui/nvim-surround"]= {},
}
