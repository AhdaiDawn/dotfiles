require("config.utils")

-- 创建自动命令组
local xmake_augroup = vim.api.nvim_create_augroup("XmakeProjectConfig", { clear = true })

-- 创建自动命令
vim.api.nvim_create_autocmd("BufEnter", {
  group = xmake_augroup,
  pattern = "xmake.lua",
  callback = function()
    vim.bo.errorformat = table.concat({
      "%*[^:]:%*\\s%f:%l:%c:%*\\serror:%\\s%m", -- 格式 1: error: file:line:col: error: msg
      "%f:%l:%c:%*\\serror:%\\s%m", -- 格式 2: file:line:col: error: msg
    }, ",")

    -- (可选) 同时设置 makeprg
    vim.bo.makeprg = "xmake"

    -- (可选) 添加其他设置或调试信息
    -- print("Xmake project detected, setting local errorformat.")
  end,
})
