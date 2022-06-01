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
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------
-- General
-----------------------------------------------------------

g.mapleader = ' ' -- change leader to a comma

local options = {
  -- mouse = 'a',               -- enable mouse support
  clipboard = 'unnamedplus', -- copy/paste to system clipboard 共享剪切板 https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl

  -- autochdir = true,          --auto to change work dir ,使用 <leader>cd替代
  backup = false,
  undofile = true,
  undodir = table.concat({ vim.call("stdpath", "cache"), "undo" }, "/"),
  swapfile = false, -- don't use a swap file
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

  updatetime = 300, -- Decrease time of completion menu.
  more = false, -- don't pause listing when screen is filled

  number = true,
  numberwidth = 2,
  relativenumber = false,

  showmode = false, -- Remove showing mode.

  cursorline = true, -- highlight the current line
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time

  termguicolors = true, -- True collor support.
  showmatch = true, -- highlight matching parenthesis
  foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
  foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
  foldlevel = 99, -- enable folding (default 'foldmarker')
  colorcolumn = "99999", -- fixes indentline for now
  splitright = true, -- vertical split to the right
  splitbelow = true, -- orizontal split to the bottom
  ignorecase = true, -- ignore case letters when search
  smartcase = true, -- ignore lowercase for the whole pattern
  wrap = false, -- display lines as one long line

  hidden = true, -- enable background buffers
  history = 100, -- remember n lines in history
  lazyredraw = true, -- faster scrolling}}}
  synmaxcol = 240, -- max column for syntax highlight

  expandtab = true, -- use spaces instead of tabs
  shiftwidth = 4, -- shift 4 spaces when tab
  tabstop = 4, -- 1 tab == 4 spaces
  smartindent = true, -- autoindent new lines

  backspace = "indent,eol,start", -- Without this option some times backspace did not work correctly.

  completeopt = 'menuone,noselect', -- insert mode completion options
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append "sI" -- disable nvim intro

vim.g.cursorhold_updatetime = 100
vim.o.background = "dark"

-- 返回上次编辑位置
autocmd("BufReadPost", {
  callback = function()
    if not fn.expand("%:p"):match ".git" and fn.line "'\"" > 1 and fn.line "'\"" <= fn.line "$" then
      cmd "normal! g'\""
      cmd "normal zz"
    end
  end,
})


-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
-- don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]

-- 2 spaces for selected filetypes
cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

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
-- disable builtins plugins
-----------------------------------------------------------
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
