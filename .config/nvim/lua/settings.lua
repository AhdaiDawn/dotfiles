-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
--local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd -- execute Vim commands
local exec = vim.api.nvim_exec -- execute Vimscript
local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------
-- General
-----------------------------------------------------------

g.mapleader = ' ' -- change leader to a comma
-- opt.mouse = 'a'               -- enable mouse support

-- 共享剪切板 https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
-- opt.autochdir = true          --auto to change work dir ,使用 <leader>cd替代

-- 返回上次编辑位置
autocmd("BufReadPost", {
  callback = function()
    if not vim.fn.expand("%:p"):match ".git" and vim.fn.line "'\"" > 1 and vim.fn.line "'\"" <= vim.fn.line "$" then
      vim.cmd "normal! g'\""
      vim.cmd "normal zz"
    end
  end,
})

opt.backup = false
opt.undofile = true
opt.undodir = table.concat({ vim.call("stdpath", "cache"), "undo" }, "/")
opt.swapfile = false -- don't use a swap file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
-- Decrease time of completion menu.
opt.updatetime = 300
vim.g.cursorhold_updatetime = 100

opt.more = false -- don't pause listing when screen is filled

opt.number = true
opt.numberwidth = 2
opt.relativenumber = false

-- Remove showing mode.
opt.showmode = false

opt.cursorline = true -- highlight the current line
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
-- True collor support.
opt.termguicolors = true

opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = "manual" -- folding, set to "expr" for treesitter based folding
opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
opt.foldlevel = 99 -- enable folding (default 'foldmarker')
opt.colorcolumn = "99999" -- fixes indentline for now
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern
opt.linebreak = true -- wrap on word boundary

-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling}}}
opt.synmaxcol = 240 -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true -- enable 24-bit RGB colors
vim.o.background = "dark"

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines

-- Without this option some times backspace did not work correctly.
opt.backspace = "indent,eol,start"

-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-----------------------------------------------------------
-- Autocompletion
-----------------------------------------------------------
-- insert mode completion options
opt.completeopt = 'menuone,noselect'

-----------------------------------------------------------
-- Terminal
-----------------------------------------------------------
-- open a terminal pane on the right using :Term
cmd [[command Term :botright vsplit term://$SHELL]]

-- Terminal visual tweaks
--- enter insert mode when switching to terminal
--- close terminal buffer on process exit
cmd [[
    autocmd TermOpen * setlocal listchars= nonumber norelativenumber nocursorline
    autocmd TermOpen * startinsert
    autocmd BufLeave term://* stopinsert
]]

-----------------------------------------------------------
-- Startup
-----------------------------------------------------------
-- disable nvim intro
opt.shortmess:append "sI"

-- disable builtins plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end
