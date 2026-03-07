return {
	-- Lua development environment
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	-- LSP Configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			-- LSP keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local fzf = require("fzf-lua")
					map("gd", fzf.lsp_definitions, "Goto Definition")
					map("gr", fzf.lsp_references, "Goto References")
					map("gi", fzf.lsp_implementations, "Goto Implementation")
					map("<leader>s", fzf.lsp_live_workspace_symbols, "Workspace Symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", fzf.lsp_code_actions, "Code Action")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
				end,
			})

			-- Get blink.cmp capabilities
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- LSP servers
			local servers = {
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
						},
					},
				},
				clangd = {},
				zls = {},
			}

			-- Auto install tools
			require("mason").setup()
			require("mason-tool-installer").setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			-- Setup LSP servers
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	-- Code formatter
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true })
				end,
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},

	-- Completion
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
				providers = {
					lazydev = {
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
	},

	-- AI completion
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		opts = {
			keymaps = {
				accept_suggestion = "<C-l>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-w>",
			},
		},
	},
}
