-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Command abbreviations
local abbrevs = {
	Q = "q",
	q1 = "q!",
	Q1 = "q!",
	Qa1 = "qa!",
	Qa = "qa",
	W = "w",
	Wq = "wq",
	WQ = "wq",
	Set = "set",
	SEt = "set",
	SET = "set",
}

for lhs, rhs in pairs(abbrevs) do
	vim.cmd(string.format("cnoreabbrev %s %s", lhs, rhs))
end

-- Plugin Manager (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	checker = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
