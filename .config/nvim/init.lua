local enable_plugin = true

local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
-- Options
------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus' -- -- Sync clipboard between OS and Neovim.
end)
vim.o.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 400 -- Decrease mapped sequence wait time
vim.o.breakindent = true -- Enable break indent
vim.o.title = true -- show title
vim.o.keywordprg = ":help" -- Replace :man with :help, fix `K` freeze | :h keywordprg
vim.o.syntax = "ON" -- maybe just set syntax
vim.o.backup = false -- set backup
vim.o.cursorline = true -- current line Highlight
vim.o.confirm = true
vim.o.number = true -- turn on line numbers
vim.o.ignorecase = true -- enable case insensitive searching
vim.o.smartcase = true -- all searches are case insensitive unless there's a capital letter
vim.o.hlsearch = true -- disable all highlighted search results
vim.o.incsearch = true -- enable incremental searching
vim.o.wrap = true -- enable text wrapping
vim.o.fileencoding = "utf-8" -- encoding set to utf-8
vim.o.showtabline = 1 -- always show the tab line  1 = if at-least 2 tab, 2 = always, 0 = never
vim.o.laststatus = 2 -- always show statusline

-- Indenting
vim.o.expandtab = true -- expand tab
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4

vim.o.scrolloff = 8 -- scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right
vim.o.splitbelow = true -- split go below
vim.o.splitright = true -- vertical split to the right
vim.o.termguicolors = true -- terminal gui colors
vim.o.background = "dark" -- use dark theme only
vim.cmd('filetype plugin on') -- set filetype
vim.o.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split' -- Preview substitutions live, as you type!
-- Undo
vim.opt.undodir = vim.fn.stdpath("data") .. "/nvim/undo"
vim.opt.undofile = true-- clean plugins

-- diasble build-in plugin
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
-- HL as amplified versions of hjkl
map({ "n", "v" }, "H", "0^") -- "beginning of line"
map({ "n", "v" }, "L", "$") --"end of line"

-- Tabs
map("n", "<leader>to", ":tabnew<CR>") -- open new Tab
map("n", "<leader>tx", ":tabclose<CR>") -- close current tab
map("n", "<leader>1", "1gt")
map("n", "<leader>2", "2gt")
map("n", "<leader>3", "3gt")
map("n", "<leader>4", "4gt")
map("n", "<leader>5", "5gt")

-- Splits  & Windows
map("n", "<leader>\\", "<C-w>v", { desc = "split window as |" })
map("n", "<leader>-", "<C-w>s", { desc = "split window as -" })
map("n", "<leader>=", "<C-w>=", { desc = "resize split window" })
map("n", "<leader>x", ":close<CR>") -- close current split

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
map("n", "<S-k>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-j>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<Cmd>:bd<CR>", { desc = "Delete Buffer and Window" })

map('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

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
map("n", "<leader>qw", ":qw<CR>", { desc = "Save & quit" })
map("n", "<leader>wq", ":qw<CR>", { desc = "Save & quit" })
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
local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })

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
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- Auto Hlsearch
vim.on_key(function(char)
    if vim.fn.mode(1) == "n" then
        local new_hlsearch = vim.iter({ "<CR>", "n", "N", "*", "#", "?", "/" }):find(vim.fn.keytrans(char)) ~= nil
        if vim.opt.hlsearch:get() ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))

------------------------------
-- Completion from :h ins-completion
vim.opt.omnifunc = "syntaxcomplete#Complete" -- Auto Completion - Enable Omni complete features
vim.cmd("set complete+=k") -- Enable Spelling Suggestions for Auto-Completion:
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.cmd([[
" Minimalist-Tab Complete
    inoremap <expr> <Tab> TabComplete()
    fun! TabComplete()
        if pumvisible()
            return "\<C-Y>"
        elseif getline('.')[col('.') - 2] =~ '\K'
            return "\<C-N>"
        else
            return "\<Tab>"
        endif
    endfun
""""""""""""""""""""""""""""""""""""""""
" Minimalist-Autocomplete
    inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
    autocmd InsertCharPre * call AutoComplete()
    fun! AutoComplete()
        if v:char =~ '\K'
            \ && getline('.')[col('.') - 4] !~ '\K'
            \ && getline('.')[col('.') - 3] =~ '\K'
            \ && getline('.')[col('.') - 2] =~ '\K' " last char
            \ && getline('.')[col('.') - 1] !~ '\K'

            call feedkeys("\<C-N>", 'n')
        end
    endfun
]])

-- Automatically Pair brackets, parethesis, and quotes
map("i", "'", "''<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")
map("i", "{;", "{};<left><left>")
map("i", "/*", "/**/<left><left>")

--------------------------------------------
--- Plugin
--------------------------------------------
if enable_plugin then
    local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
        local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
        if vim.v.shell_error ~= 0 then
            error('Error cloning lazy.nvim:\n' .. out)
        end
    end

    local rtp = vim.opt.rtp
    rtp:prepend(lazypath)

    require('lazy').setup({
        { 
            "ellisonleao/gruvbox.nvim" ,
            config = function()
                vim.cmd([[colorscheme gruvbox]])
            end,
        },
        {
            "ibhagwan/fzf-lua",
            keys = {
                { "<leader>;", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
                { "<leader>f", "<cmd>FzfLua files<cr>", desc = "fzf files" },
                { "<leader>b", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
                { "<leader>r", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
                { "<leader>/", "<cmd>FzfLua grep_curbuf<cr>", desc = "Buffer" },
                { "<leader>m", "<cmd>FzfLua marks<cr>", desc = "marks" },
            },
        },
    }, {
        ui = {
            icons = vim.g.have_nerd_font and {} or {
                cmd = '⌘',
                config = '🛠',
                event = '📅',
                ft = '📂',
                init = '⚙',
                keys = '🗝',
                plugin = '🔌',
                runtime = '💻',
                require = '🌙',
                source = '📄',
                start = '🚀',
                task = '📌',
                lazy = '💤 ',
            },
        },
    })
end
--------------------------------------------
--- Plugin end
--------------------------------------------
