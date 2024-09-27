-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "gruvchad",

  statusline = {
    theme = "vscode_colored",    -- default, vscode, vscode_colored or minimal
    separator_style = "default", -- default, round, block or arrow
  }
}

return M
