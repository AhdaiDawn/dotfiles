return {
	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"java",
				"html",
				"javascript",
				"typescript",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"json",
				"toml",
				"xml",
				"yaml",
			},
			highlight = {
				enable = true,
				use_languagetree = true,
			},
		},
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- Git signs
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
	},

	-- LazyGit
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

	-- FZF
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		keys = {
			{ "<leader>p", "<cmd>FzfLua<cr>", desc = "FZF" },
			{ "<leader>o", "<cmd>FzfLua files<cr>", desc = "Find files" },
			{ "<leader>f", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
			{ "<leader>b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
			{ "<leader>r", "<cmd>FzfLua oldfiles<cr>", desc = "Recent files" },
			{ "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search in buffer" },
			{ "<leader>m", "<cmd>FzfLua marks<cr>", desc = "Marks" },
			{ "<leader>j", "<cmd>FzfLua jumps<cr>", desc = "Jumps" },
			{ "gw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },
		},
		opts = {
			winopts = {
				width = 1.0,
				height = 1.0,
				row = 0.5,
				col = 0.5,
			},
			keymap = {
				fzf = {
					["ctrl-q"] = "select-all+accept",
				},
			},
		},
	},

	-- Auto clear search highlight
	{ "romainl/vim-cool", event = "VeryLazy" },
}
