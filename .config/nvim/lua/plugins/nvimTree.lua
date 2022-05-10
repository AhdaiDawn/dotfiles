-----------------------------------------------------------
-- File manager configuration file
-----------------------------------------------------------

-- Plugin: nvim-tree
-- https://github.com/kyazdani42/nvim-tree.lua

-- Keybindings are defined in `keymapping.lua`:
--- https://github.com/kyazdani42/nvim-tree.lua#keybindings

-- Note: options under the g: command should be set BEFORE running the
--- setup function:
--- https://github.com/kyazdani42/nvim-tree.lua#setup
--- See: `help NvimTree`
local g                            = vim.g
g.nvim_tree_git_hl                 = 1
g.nvim_tree_highlight_opened_files = 1
g.nvim_tree_respect_buf_cwd        = 1
g.nvim_tree_width_allow_resize     = 1

g.nvim_tree_show_icons = {
  folders = 1,
  files = 1,
  git = 1,
  folder_arrows = 1,
}

g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    deleted = "",
    ignored = "◌",
    renamed = "➜",
    staged = "✓",
    unmerged = "",
    unstaged = "✗",
    untracked = "★",
  },
  folder = {
    default = "",
    empty = "",
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = "",
    arrow_open = "",
    arrow_closed = "",
  },
}

require('nvim-tree').setup {
  open_on_setup = true,
  filters = {
    dotfiles = false,
    custom = { '.git', 'node_modules', '.cache', '.bin' },
  },
}
