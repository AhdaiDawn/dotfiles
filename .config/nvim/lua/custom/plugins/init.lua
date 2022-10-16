return {
  -- 复制到系统剪切板
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
}
