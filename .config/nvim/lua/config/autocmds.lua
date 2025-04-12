-- 复制当前文件名:行数 autocmds.lua:1
function CopyFileLine()
    local file_name = vim.fn.expand('%:t')
    if file_name == '' then
        file_name = '[No Name]'  -- 未保存文件时的占位符
    end
    local line_num = vim.fn.line('.')
    local str = file_name .. ':' .. line_num
    vim.fn.setreg('+', str)
end

