local map = vim.keymap.set
pcall(vim.keymap.del, "n", "<leader>l")
pcall(vim.keymap.del, { "n", "i", "v" }, "<A-j>")
pcall(vim.keymap.del, { "n", "i", "v" }, "<A-k>")

map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
