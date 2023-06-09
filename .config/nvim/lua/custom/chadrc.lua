local M = {}

M.ui = {
  theme = "gruvbox",

  tabufline = {
    enabled = false,
  },
}

M.plugins = "custom.plugins"

M.mappings = require "custom.mappings"

return M
