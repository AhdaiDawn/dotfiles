local map = vim.keymap.set
local unmap = vim.keymap.del

unmap("n", "<leader>l")
unmap({ "n", "i", "v" }, "<A-j>")
unmap({ "n", "i", "v" }, "<A-k>")

map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
