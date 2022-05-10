vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup {
  space_char_blankline = " ",
  show_current_context = true,
  indent_blankline_use_treesitter = true,
  -- show_current_context_start = true,

  buftype_exclude = { "terminal", "nofile", "help" },
  filetype_exclude = {
    "help",
    "toggleterm",
    "alpha",
    "packer",
    "lsp-installer",
    "lspinfo",
    "vista_kind",
    "terminal",
    "TelescopePrompt",
    "TelescopeResults",
  },
}
