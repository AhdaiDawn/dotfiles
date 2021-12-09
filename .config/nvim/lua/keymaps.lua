-----------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local cmd = vim.cmd

-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

-- clear search highlighting
-- map('n', '<leader>c', ':nohl<CR>', default_opts)

-- fast saving with <leader>
map('n', '<leader>fs', ':w<CR>', default_opts)

map('i', '<C-f>', '<right>', default_opts)

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- splits windows
map('n', '<leader>w\\', '<C-w>v', default_opts)
map('n', '<leader>w-', '<C-w>s', default_opts)
map('n', '<leader>w=', '<C-w>=', default_opts)

-- close all windows and exit from neovim
map('n', '<leader>qq', ':q<CR>', default_opts)
map('n', '<leader>wq', ':wq<CR>', default_opts)
map('n', '<leader>x', ':bdelete<CR>', default_opts)

-- tab
map('n', '<leader>tn', ':tabnew<CR>', default_opts)
map('n', '<leader>tq', ':tabclose<CR>', default_opts)
map('n', '<leader>to', ':tabonly<CR>', default_opts)
map('n', '<leader>1', '1gt', default_opts)
map('n', '<leader>2', '2gt', default_opts)
map('n', '<leader>3', '3gt', default_opts)
map('n', '<leader>4', '4gt', default_opts)
map('n', '<leader>5', '5gt', default_opts)


-----------------------------------------------------------
-- Applications & Plugins shortcuts:
-----------------------------------------------------------
-- open terminal
map('n', '<leader>tt', ':Term<CR>', { noremap = true })
map('t', 'jj', '<C-\\><C-n>', default_opts)

-- nvim-tree
map('n', '<leader>r', ':NvimTreeRefresh<CR>', default_opts)  -- refresh
map('n', '<leader>n', ':NvimTreeToggle<CR>', default_opts) -- search file

-- find
map('n', '<leader>ff', ':Telescope find_files<CR>', default_opts) -- search file
map('n', '<leader>m', ':Telescope oldfiles<CR>', default_opts) -- search file
map('n', '<leader>b', ':Telescope buffers<CR>', default_opts) -- search file
map('n', '<leader>fl', ':Telescope live_grep<CR>', default_opts) -- search file
map('n', '<leader>fh', ':Telescope help_tags<CR>', default_opts) -- search file
map('n', '<leader>ft', ':Telescope tags<CR>', default_opts) -- search file
map('n', '<leader>fc', ':Telescope command_history<CR>', default_opts) -- search command_history
map('n', '<leader>fp', ':Telescope projects<CR>', default_opts) -- search command_history
map('n', '<leader>fm', ':Telescope marks<CR>', default_opts) -- search marks
map('n', '<leader>fq', ':Telescope quickfix<CR>', default_opts) -- search marks
map('n', '<leader>gm', ':Telescope git_commits<CR>', default_opts) -- search commits
map('n', '<leader>gb', ':Telescope git_branches<CR>', default_opts) -- search command_history
map('n', '<leader>gs', ':Telescope git_status<CR>', default_opts) -- search command_history
-- Vista tag-viewer
map('n', '<C-m>', ':Vista!!<CR>', default_opts)   -- open/close

map('n', '<leader>cd', ':ProjectRoot<CR>', default_opts) -- 工作目录为当前文件目录
map('v', '<leader>c', ':s/\\\\/\\//g<CR>', default_opts)   --windows path to linux path

