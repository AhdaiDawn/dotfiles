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
    },
  },

  -- File Explorer (Buffer-like)
  {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
      {
        "<A-e>",
        function()
          require("oil").toggle_float()
        end,
        desc = "Toggle Oil float file explorer",
        mode = { "n", "v" },
      },
    },
    opts = {
      float = {
        padding = 2,
        max_width = 90,
        max_height = 30,
        border = "rounded",
      },
    },
  },
}
