return {
  {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "hard",
      })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
      picker = {
        hidden = true,
        -- ignored = true,
        sources = {
          files = {
            hidden = true,
            -- ignored = true,
          },
        },
      },
    },
    keys = {
      -- find
      { "<leader>o", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
      { "<leader>r", LazyVim.pick("oldfiles"), desc = "Recent" },
      { "<leader>e", false },
    },
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>e",
        "<cmd>Yazi<cr>",
        desc = "Yazi (Current File)",
      },
    },
    opts = {},
  },
  {
    "fei6409/log-highlight.nvim",
    opts = {},
  },
}
