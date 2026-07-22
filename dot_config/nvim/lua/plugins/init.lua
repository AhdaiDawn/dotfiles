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
      lazygit = {
        config = {
          os = {
            -- Snacks' nvim-remote preset uses --remote-tab. Keep the remote
            -- integration, but open the selected file in the current window.
            edit = [=[[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})]=],
            editAtLine = [=[[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")]=],
            openDirInEditor = [=[[ -z "$NVIM" ] && (nvim -- {{dir}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{dir}})]=],
          },
        },
      },
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
    config = function(_, opts)
      require("log-highlight").setup(opts)

      vim.api.nvim_create_user_command("LogHighlightToggle", function()
        if vim.bo.syntax == "log" then
          vim.bo.syntax = vim.b.log_highlight_previous_syntax or ""
          vim.b.log_highlight_previous_syntax = nil
        else
          vim.b.log_highlight_previous_syntax = vim.bo.syntax
          vim.bo.syntax = "log"
        end
      end, { desc = "Toggle log highlighting for the current buffer", force = true })
    end,
  },
}
