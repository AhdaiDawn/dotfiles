-- del keymap
local nomap = vim.keymap.del
nomap("n", "<leader>l")
nomap("n", "<leader>|")
nomap("n", "<leader>bD")

-- set keymap
local map = vim.keymap.set

map("n", "<leader>fs", "<cmd> w <CR>", { desc = "save" })

map("n", "<leader>1", "1gt")
map("n", "<leader>2", "2gt")
map("n", "<leader>3", "3gt")
map("n", "<leader>4", "4gt")
map("n", "<leader>5", "5gt")

map("n", "<leader>\\", "<C-W>v", { desc = "Split Window Right" })

map("n", "<leader>bx", "<Cmd>:bd<CR>", { desc = "Delete Buffer and Window" })
