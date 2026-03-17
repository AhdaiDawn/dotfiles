-- Options
vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

local opt = vim.opt

-- UI
opt.number = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.showmode = false
opt.title = true
opt.laststatus = 3
opt.showtabline = 1
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.wrap = true
opt.breakindent = true
opt.background = "dark"

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.inccommand = "split"

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Scroll & Split
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true

-- File & System
opt.fileencoding = "utf-8"
opt.mouse = "a"
vim.schedule(function()
	opt.clipboard = "unnamedplus"
end)
opt.updatetime = 250
opt.timeoutlen = 400
opt.backup = false
opt.swapfile = false
opt.confirm = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true

-- Disable built-in plugins
local disabled_plugins = {
	"netrw",
	"netrwPlugin",
	"matchit",
	"matchparen",
	"remote_plugins",
	"shada_plugin",
	"spellfile_plugin",
	"gzip",
	"tar",
	"tarPlugin",
	"zip",
	"zipPlugin",
	"2html_plugin",
	"tutor_mode_plugin",
}

for _, plugin in ipairs(disabled_plugins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Disable providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
