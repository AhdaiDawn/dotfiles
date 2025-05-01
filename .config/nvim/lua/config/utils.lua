-- 复制当前文件名:行数 autocmds.lua:1
vim.api.nvim_create_user_command(
  "CopyFileLine", -- 命令名称
  function() -- Lua 函数作为 command
    local file_name = vim.fn.expand("%:t")
    if file_name == "" then
      file_name = "[No Name]" -- 未保存文件时的占位符
    end
    local line_num = vim.fn.line(".")
    local str = file_name .. ":" .. line_num
    vim.fn.setreg("+", str)
  end,
  {
    desc = "复制当前文件名:行数 autocmds.lua:1", -- 描述 (推荐)
    nargs = 0, -- 不接受参数
  }
)
