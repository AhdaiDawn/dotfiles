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

-- Don't copy the replaced text after pasting.
-- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
map("v", "p", 'p:let @+=@0<CR>:let @"=@0<CR>', default_opts)

-- use ESC to turn off search highlighting
map("n", "<Esc>", "<cmd> :noh <CR>", default_opts)

-- fast saving with <leader>
map('n', '<leader>fs', ':w<CR>', default_opts)

map('i', '<C-f>', '<right>', default_opts)

-- move around splits using Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)

-- splits windows
map('n', '<leader>\\', '<C-w>v', default_opts)
map('n', '<leader>-', '<C-w>s', default_opts)
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
vim.defer_fn(function()
  -- nvim-tree
  map('n', '<leader>n', ':NvimTreeFindFileToggle<CR>', default_opts) -- open fileExplorer

  -- find
  map('n', '<leader>ff', ':Telescope find_files<CR>', default_opts)
  map('n', '<leader>m', ':Telescope oldfiles<CR>', default_opts)
  map('n', '<leader>b', ":lua require('telescope.builtin').buffers({ sort_mru=true, ignore_current_buffer=true })<CR>", default_opts)
  map('n', '<leader>fl', ':Telescope live_grep<CR>', default_opts)
  map('n', '<leader>fh', ':Telescope help_tags<CR>', default_opts)
  map('n', '<leader>ft', ':Telescope tags<CR>', default_opts)
  map('n', '<leader>fc', ':Telescope command_history<CR>', default_opts)
  map('n', '<leader>fp', ':Telescope projects<CR>', default_opts)
  map('n', '<leader>fm', ':Telescope marks<CR>', default_opts)
  map('n', '<leader>fq', ':Telescope quickfix<CR>', default_opts)
  map('n', '<leader>fd', ':Telescope diagnostics<CR>', default_opts)

  map('n', '<leader>cd', ':ProjectRoot<CR>', default_opts) -- 切换工作目录为当前文件目录

  -- term
  map("t", "<esc>", "<C-\\><C-n>", default_opts)

  -- 使用OSC yank
  cmd [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]]
end, 0)
