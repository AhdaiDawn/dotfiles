local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
-- Options
------------------------------
vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- UI
vim.o.number = true -- turn on line numbers
vim.o.termguicolors = true -- terminal gui colors
vim.o.signcolumn = "yes" -- Keep signcolumn on by default
vim.o.cursorline = true -- current line Highlight
vim.o.showmode = false
vim.o.title = true -- show title
vim.o.laststatus = 3 -- always show statusline
vim.o.showtabline = 1 -- always show the tab line  1 = if at-least 2 tab, 2 = always, 0 = never
vim.o.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.wrap = true -- enable text wrapping
vim.o.breakindent = true -- Enable break wq
vim.o.background = "dark" -- use dark theme only

-- search
vim.o.ignorecase = true -- enable case insensitive searching
vim.o.smartcase = true -- all searches are case insensitive unless there's a capital letter
vim.o.hlsearch = true -- disable all highlighted search results
vim.o.incsearch = true -- enable incremental searching
vim.o.inccommand = "split" -- Preview substitutions live, as you type!

-- Indenting
vim.o.expandtab = true -- expand tab
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

--scroll & split
vim.o.scrolloff = 8 -- scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right
vim.o.splitbelow = true -- split go below
vim.o.splitright = true -- vertical split to the right

-- file & system
vim.o.fileencoding = "utf-8" -- encoding set to utf-8
vim.o.mouse = "a"
vim.schedule(function()
	vim.o.clipboard = "unnamedplus" -- -- Sync clipboard between OS and Neovim.
end)
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 400 -- Decrease mapped sequence wait time
vim.o.backup = false -- set backup
vim.o.confirm = true
vim.cmd("filetype plugin on") -- set filetype
vim.opt.undodir = vim.fn.stdpath("data") .. "/nvim/undo"
vim.opt.undofile = true -- clean plugins

-- diasble build-in plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Keymaps
------------------------------
-- Line movement Soft wrap movement fix
map("n", "j", "gj") -- move vert by visual line
map("n", "k", "gk") -- move vert by visual line

map("i", "<C-f>", "<Right>")

-- Splits  & Windows
map("n", "<leader>\\", "<C-w>v", { desc = "split window as |" })
map("n", "<leader>-", "<C-w>s", { desc = "split window as -" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Split Navigation
map("n", "<C-h>", "<C-w>h") -- control+h switches to left split
map("n", "<C-l>", "<C-w>l") -- control+l switches to right split
map("n", "<C-j>", "<C-w>j") -- control+j switches to bottom split
map("n", "<C-k>", "<C-w>k") -- control+k switches to top split

-- buffer navigation
map("n", "H", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "L", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>x", "<Cmd>:bd<CR>", { desc = "Delete Buffer and Window" })
for i = 1, 9 do
	map(
		"n",
		"<leader>" .. i,
		':lua require("bufferline").go_to_buffer(' .. i .. ", true)<CR>",
		{ noremap = true, silent = true }
	)
end

map("n", "<leader>qf", "<Cmd>:copen<CR>", { desc = "Open Quickfix" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Clipboard
-- paste text but DONT copy the overridden text
map("v", "<leader>p", [["_dP]])
-- delete text but DONT copy to clipboard
map({ "n", "v" }, "<leader>d", [["_d]])

-- Move line
map("v", "<A-j>", ":m '>+1<CR>gv=gv") -- Move current line down
map("v", "<A-k>", ":m '<-2<CR>gv=gv") -- Move current line up
-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>fs", "<cmd> w <CR>", { desc = "save" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Quit
map("n", "<leader>qw", ":wq<CR>", { desc = "Save & quit" })
map("n", "<leader>wq", ":wq<CR>", { desc = "Save & quit" })
map("n", "<leader>q!", ":q!<CR>", { desc = "Quit all buffer without save" })
map("n", "<leader>q1", ":q!<CR>", { desc = "Quit all buffer without save" })
map("n", "<leader>qq", ":q<CR>", { desc = "Quit buffer without save" })
map("n", "<leader>qa", ":qa<CR>", { desc = "Quit all buffer with save" })

-- Abbrev
vim.cmd("cnoreabbrev Q  q")
vim.cmd("cnoreabbrev q1  q!")
vim.cmd("cnoreabbrev Q1  q!")
vim.cmd("cnoreabbrev Qa1 qa!")
vim.cmd("cnoreabbrev Qa qa")
vim.cmd("cnoreabbrev W  w")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev Set set")
vim.cmd("cnoreabbrev SEt set")
vim.cmd("cnoreabbrev SET set")

-- AutoCOMMANDS
------------------------------
-- Mode based Cursorline
autocmd("InsertEnter", {
	pattern = "*",
	callback = function()
		vim.o.cursorline = false
	end,
})
autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		vim.o.cursorline = true
	end,
})

-- 恢复光标位置
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line("'\"")
		if
			line > 1
			and line <= vim.fn.line("$")
			and vim.bo.filetype ~= "commit"
			and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
		then
			vim.cmd('normal! g`"')
		end
	end,
})

--------------------------------------------
--- Plugin
--------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
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
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				numbers = "ordinal",
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "gruvbox",
				globalstatus = true,
			},
		},
	},
	{
		"ggandor/leap.nvim",
		enabled = true,
		config = function(_, opts)
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
			vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFileToggle" },
		keys = {
			{ "<A-e>", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTreeToggle" },
		},
		opts = {
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
		},
	},
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
			-- indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		"ibhagwan/fzf-lua",
		cmd = "FzfLua",
		keys = {
			{ "<leader>p", "<cmd>FzfLua<cr>", desc = "fzf" },
			{ "<leader>o", "<cmd>FzfLua files<cr>", desc = "fzf files" },
			{ "<leader>f", "<cmd>FzfLua live_grep<cr>", desc = "fzf live_grep" },
			{ "<leader>b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
			{ "<leader>r", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
			{ "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
			{ "<leader>m", "<cmd>FzfLua marks<cr>", desc = "marks" },
			{ "<leader>j", "<cmd>FzfLua jumps<cr>", desc = "jumps" },
			{ "gw", "<cmd>FzfLua grep_cword<cr>", desc = "FZF word (under cursor)" },
		},
		opts = function(_, opts)
			return {
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
			}
		end,
	},
	{ "romainl/vim-cool", event = "VeryLazy" },
	{ import = "plugins" },
})
--------------------------------------------
--- Plugin end
--------------------------------------------
