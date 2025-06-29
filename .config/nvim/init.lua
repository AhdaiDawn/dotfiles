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
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time
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
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true -- expand tab
vim.o.smartindent = true
vim.o.scrolloff = 8 -- scroll page when cursor is 8 lines from top/bottom
vim.o.sidescrolloff = 8 -- scroll page when cursor is 8 spaces from left/right
vim.o.splitbelow = true -- split go below
vim.o.splitright = true -- vertical split to the right
vim.o.termguicolors = true -- terminal gui colors
vim.o.background = "dark" -- use dark theme only
vim.cmd('colorscheme gruvbox') -- set colorscheme
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

-- Replace all instances of highlighted words
map("v", "<leader>r", '"hy:%s/<C-r>h//g<left><left>')

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

local group = vim.api.nvim_create_augroup("user_cmds", { clear = true })
-- Highlight Yank
autocmd("TextYankPost", {
    group = group,
    desc = "Highlight on yank",
    callback = function()
        vim.highlight.on_yank({ higroup = "ErrorMsg", timeout = 300 })
    end,
})

-- Find
vim.api.nvim_create_user_command(
  'Find',
  function(opts)
    vim.cmd('cexpr system("rg --vimgrep ' .. opts.args .. '")')
    vim.cmd('copen')
  end,
  { nargs = '+', complete = 'file' }
)
map("n", "<leader>f", ':Find ')

------------------------------
-- FileBrowser
map("n", "<M-e>", ":Lex<CR>") -- space+e toggles netrw tree view
vim.g.netrw_browse_split = 4 -- open in prior window
vim.g.netrw_keepdir = 0 -- Sync current directory with browsing directory
vim.g.netrw_altv = 1 -- change from left splitting to right splitting
vim.g.netrw_banner = 0 -- gets rid of the annoying banner for netrw
vim.g.netrw_liststyle = 3 -- tree style view in netrw
vim.g.netrw_winsize = 15 -- window size
-- Netrw Keymaps
local function netrw_mapping()
    local bufmap = function(lhs, rhs)
        local opts = { buffer = true, remap = true }
        vim.keymap.set("n", lhs, rhs, opts)
    end

    -- Go back in history
    bufmap("H", "u")

    -- Go up a directory
    bufmap("h", "-^")

    -- Open file/directory
    bufmap("l", "<cr>")

    -- Open file/directory then close explorer
    bufmap("L", "<cr>:Lexplore<CR>")

    -- Toggle dotfiles
    bufmap(".", "gh")
end
vim.api.nvim_create_autocmd("FileType", {
    pattern = "netrw",
    group = group,
    desc = "Keybindings for netrw",
    callback = netrw_mapping,
})
------------------------------
-- Completion from :h ins-completion
vim.opt.omnifunc = "syntaxcomplete#Complete" -- Auto Completion - Enable Omni complete features
vim.cmd("set complete+=k") -- Enable Spelling Suggestions for Auto-Completion:
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.cmd([[
" Minimalist-Tab Complete
    inoremap <expr> <Tab> TabComplete()
    fun! TabComplete()
        if getline('.')[col('.') - 2] =~ '\K' || pumvisible()
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

--------------------------------
-- ************** YANK RING ***************************
-- ─────────────── REGISTER ALLOCATION SCHEME ────────────────────────
-- ╭───┬──────────────────────────┬───┬──────────────────╮
-- │ 1 │ Last delete              │ 0 │ Last yank        │
-- │ 2 │ Second last delete       │ 9 │ Second last yank │
-- │ 3 │ Third last delete        │ 8 │ Third last yank  │
-- │ 4 │ Fourth last delete       │ 7 │ Fourth last yank │
-- │ 5 │ Fifth last delete        │ 6 │ Fifth last yank  │
-- ╰───┴──────────────────────────┴───┴──────────────────╯
local prev0, prev9
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("yank_history", {}),
    desc = "Store previous yanks in latter half of numbered registers (VimEnter hooks)",
    pattern = "*",
    callback = function()
        prev0 = vim.fn.getreginfo("0")
        prev9 = vim.fn.getreginfo("9")
    end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = "yank_history",
    desc = "Store previous yanks in latter half of numbered registers",
    pattern = "*",
    callback = function()
        if vim.v.event.regname ~= "" then
            return
        end
        vim.fn.setreg("6", vim.fn.getreginfo("7"))
        vim.fn.setreg("7", vim.fn.getreginfo("8"))
        vim.fn.setreg("8", vim.fn.getreginfo("9"))
        if vim.v.event.operator == "y" then
            prev0.isunnamed = false
            vim.fn.setreg("9", prev0)
            prev9 = vim.fn.getreginfo("9")
            prev0 = vim.fn.getreginfo("0")
        else
            vim.fn.setreg("9", prev9)
        end
    end,
})

-- *** Everything below implements cycle functionality ***
local last_put_type = nil
local last_cycle_register = nil
vim.api.nvim_create_augroup("yank_cycle", {})
local function register_autocmd()
    vim.api.nvim_create_autocmd("CursorMoved", {
        group = "yank_cycle",
        desc = "Disallow cycling when cursor was moved, or cursorline changed",
        pattern = "*",
        callback = function()
            last_put_type = nil
            last_cycle_register = nil
        end,
    })
end

local function hook_put_actions(mode, key)
    vim.keymap.set(mode, key, function()
        last_put_type = key
        vim.api.nvim_clear_autocmds({ group = "yank_cycle" })
        vim.schedule(register_autocmd)
        return key
    end, { expr = true, desc = "Track put actions" })
end
for _, key in ipairs({ "p", "P", "gp", "gP", "zp", "zP", "[p", "]p" }) do
    hook_put_actions("n", key)
end
local function cycle_put(amount)
    return function()
        if last_put_type ~= nil then
            if last_cycle_register == nil then
                last_cycle_register = tonumber(vim.fn.getreginfo('"').points_to) or 0
            end
            last_cycle_register = (last_cycle_register + amount) % 10
            local meta = getmetatable(vim.fn.getreginfo(tostring(last_cycle_register)))
            if meta ~= getmetatable(vim.empty_dict()) then
                vim.cmd.normal(string.format('u"%d%s', last_cycle_register, last_put_type))
                vim.api.nvim_echo({ { string.format("Paste using [%d/9]", last_cycle_register) } }, false, {})
            else
                vim.api.nvim_echo(
                    { { string.format("Skipping register %d since it's empty", last_cycle_register), "ErrorMsg" } },
                    false,
                    {}
                )
            end
        else
            vim.api.nvim_echo({ { "Cannot cycle put. Cursor has moved", "ErrorMsg" } }, false, {})
        end
    end
end
vim.keymap.set("n", "<c-n>", cycle_put(1), { desc = "Swap put with next register" })
vim.keymap.set("n", "<c-p>", cycle_put(-1), { desc = "Swap put with previous register" })

