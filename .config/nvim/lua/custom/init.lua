local cmd = vim.cmd

vim.defer_fn(function()
  -- 使用OSC yank
  cmd [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]]
  vim.g['oscyank_term'] = 'default'
end, 0)
