return {
	-- Colorscheme
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				contrast = "hard",
			})
			vim.cmd([[colorscheme gruvbox]])
		end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				numbers = "ordinal",
				close_command = "bdelete! %d",
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						text_align = "center",
					},
				},
			},
		},
	},

	-- Statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				theme = "gruvbox",
				globalstatus = true,
			},
		},
	},

	-- Motion
	{
		url = "https://codeberg.org/andyg/leap.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, desc = "Leap forward" },
			{ "S", mode = "n", desc = "Leap from windows" },
		},
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
			vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
		end,
	},

	-- File Explorer
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle" },
		keys = {
			{ "<A-e>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "Toggle file explorer" },
		},
		opts = {
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			view = {
				width = 30,
			},
			renderer = {
				group_empty = true,
				icons = {
					git_placement = "after",
				},
			},
			filters = {
				dotfiles = false,
			},
		},
	},
}
