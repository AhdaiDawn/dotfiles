require "nvchad.options"
local autocmd = vim.api.nvim_create_autocmd

-- add yours here!

if jit.os == "Windows" then
  vim.o.shell = "pwsh"
end

-- 恢复光标位置
autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

