-----------------------------------------------------------
-- Neovim settings
-----------------------------------------------------------

-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
--local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd         -- execute Vim commands
local exec = vim.api.nvim_exec  -- execute Vimscript
local fn = vim.fn           -- call Vim functions
local g = vim.g             -- global variables
local opt = vim.opt           -- global/buffer/windows-scoped options

-----------------------------------------------------------
-- General
-----------------------------------------------------------

g.mapleader = ' '             -- change leader to a comma
-- opt.mouse = 'a'               -- enable mouse support

-- 共享剪切板 https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
opt.clipboard = 'unnamedplus' -- copy/paste to system clipboard
opt.swapfile = false          -- don't use swapfile
-- opt.autochdir = true          --auto to change work dir ,使用 <leader>cd替代

-- 返回上次编辑位置
cmd [[
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
]]

exec([[
    " 允许备份
    set backup

    " 保存时备份
    set writebackup

    " 备份文件地址，统一管理
    set backupdir=~/.vimtemp/backup

    " 备份文件扩展名
    set backupext=.bak

    " 禁用交换文件
    set noswapfile

    set undofile "设置撤回文件
    set undodir=~/.vimtemp/undo-dir//

    " 创建目录，并且忽略可能出现的警告
    silent! call mkdir(expand('~/.vimtemp/backup'), "p", 0755)
]], false)
-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
-- Decrease time of completion menu.
opt.updatetime = 300
vim.g.cursorhold_updatetime = 100

opt.number = true             -- show line number{{{{{{{{{

-- Remove showing mode.
opt.showmode = false

-- True collor support.
opt.termguicolors = true

opt.showmatch = true          -- highlight matching parenthesis
-- opt.foldmethod = 'syntax'     -- enable folding (default 'foldmarker')
opt.foldlevel = 99     -- enable folding (default 'foldmarker')
opt.colorcolumn = '80'        -- line lenght marker at 80 columns
opt.splitright = true         -- vertical split to the right
opt.splitbelow = true         -- orizontal split to the bottom
opt.ignorecase = true         -- ignore case letters when search
opt.smartcase = true          -- ignore lowercase for the whole pattern
opt.linebreak = true          -- wrap on word boundary

-- remove whitespace on save
cmd [[au BufWritePre * :%s/\s\+$//e]]


-- highlight on yank
exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
  augroup end
]], false)

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true         -- enable background buffers
opt.history = 100         -- remember n lines in history
opt.lazyredraw = true     -- faster scrolling}}}
opt.synmaxcol = 240       -- max column for syntax highlight

-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true      -- enable 24-bit RGB colors
vim.o.background =  "dark"--}}}

-----------------------------------------------------------
-- Tabs, indent}}}
-----------------------------------------------------------
opt.expandtab = true      -- use spaces instead of tabs
opt.shiftwidth = 4        -- shift 4 spaces when tab
opt.tabstop = 4           -- 1 tab == 4 spaces
opt.smartindent = true    -- autoindent new lines

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

local NoWhitespace = exec(
  [[
    function! NoWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfunction
    call NoWhitespace()
    ]],
  true
)

-- Trim Whitespace
exec([[au BufWritePre * call NoWhitespace()]], false)

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
