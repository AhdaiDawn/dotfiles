local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<leader>l")

map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
