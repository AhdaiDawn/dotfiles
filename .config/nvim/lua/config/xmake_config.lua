-- 将你的 errorformat 存储在一个变量中，更清晰
local xmake_errorformat = table.concat({
  "%*[^:]:%*\\s%f:%l:%c:%*\\serror:%\\s%m", -- 格式 1: error: file:line:col: error: msg
  "%f:%l:%c:%*\\serror:%\\s%m", -- 格式 2: file:line:col: error: msg
}, ",")

-- 创建自动命令组
local xmake_augroup = vim.api.nvim_create_augroup("XmakeProjectConfig", { clear = true })

-- 创建自动命令
vim.api.nvim_create_autocmd("BufEnter", {
  group = xmake_augroup,
  pattern = "*", -- 匹配所有文件
  callback = function()
    -- vim.fn.findfile 调用 Vim 的 findfile 函数
    -- ';' 告诉它向上搜索目录树
    local xmake_root_file = vim.fn.findfile("xmake.lua", vim.fn.getcwd())

    -- 检查是否找到了文件 (返回值非空)
    if xmake_root_file ~= "" then
      -- 设置当前 buffer 的局部 errorformat
      vim.bo.errorformat = xmake_errorformat -- vim.bo 指向当前 buffer 的选项

      -- (可选) 同时设置 makeprg
      vim.bo.makeprg = "xmake"

      -- (可选) 添加其他设置或调试信息
      -- print("Xmake project detected, setting local errorformat.")
    end
  end,
})

return {}
