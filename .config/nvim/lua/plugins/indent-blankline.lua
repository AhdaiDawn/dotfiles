-----------------------------------------------------------
-- Indent line configuration file
-----------------------------------------------------------

-- Plugin: indent-blankline
-- https://github.com/lukas-reineke/indent-blankline.nvim

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require('indent_blankline').setup {
  space_char_blankline = " ",
  show_first_indent_level = false,
  filetype_exclude = {
    'help',
    'git',
    'markdown',
    'text',
    'terminal',
    'lspinfo',
    'packer'
  },
  buftype_exclude = {
    'terminal',
    'nofile'
  },
}
