local cmd = vim.cmd

cmd [[colorscheme gruvbox]]

cmd [[autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif]]

