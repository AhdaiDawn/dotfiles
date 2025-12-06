return {
  -- 1. 配置 Lua 开发环境（仅针对编辑 Neovim 配置文件时）
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } },
  },

  -- 2. LSP 核心配置 (管理 + 快捷键 + 自动安装)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} }, -- 必须先加载 Mason
      "mason-org/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp", -- 补全插件
    },
    config = function()
      -- -- 定义 LSP 启动后的按键映射 (只保留了最常用的)
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          local fzf = require "fzf-lua"
          map("gd", fzf.lsp_definitions, "[G]oto [D]efinition")
          map("gr", fzf.lsp_references, "[G]oto [R]eferences")
          map("gi", fzf.lsp_implementations, "[G]oto [I]mplementation")
          map("<leader>s", fzf.lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame") -- 变量重命名
          map("<leader>ca", fzf.lsp_code_actions, "[C]ode [A]ction") -- 代码操作(自动修复等)
          map("K", vim.lsp.buf.hover, "Hover Documentation") -- 查看文档
        end,
      })

      -- 获取 blink.cmp 的能力，以此来告诉 LSP 服务器
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- 在这里列出你想启用的 LSP 服务器
      local servers = {
        lua_ls = { settings = { Lua = { completion = { callSnippet = "Replace" } } } },
        clangd = {},
        -- pyright = {},
        -- tsserver = {},
      }

      -- 自动安装缺失的工具
      require("mason").setup()
      require("mason-tool-installer").setup { ensure_installed = vim.tbl_keys(servers) }

      -- 自动配置所有服务器
      require("mason-lspconfig").setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end,
  },

  -- 3. 代码格式化 (Autoformat)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format { async = true }
        end,
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        -- python = { "isort", "black" },
      },
    },
  },

  -- 4. 自动补全 (Blink.cmp)
  {
    "saghen/blink.cmp",
    event = "VimEnter",
    version = "1.*",
    dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
    opts = {
      keymap = { preset = "super-tab" },
      appearance = { nerd_font_variant = "mono" },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "lazydev" },
        providers = { lazydev = { module = "lazydev.integrations.blink", score_offset = 100 } },
      },
    },
  },

  -- 5. AI
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      keymaps = {
        accept_suggestion = "<C-j>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-w>",
      },
    },
  },
}
