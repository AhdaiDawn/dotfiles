return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = "nvim-lua/plenary.nvim",
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
    keys = {
      -- find
      { "<leader>o", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>r", LazyVim.pick("oldfiles"), desc = "Recent" },
      {
        "<A-e>",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "Explorer Snacks (root dir)",
      },
    },
  },
}
