require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "<C-f>", "<Right>", { desc = "move right" })
map("i", "<C-b>", "<Left>", { desc = "move left" })

map("n", "H", "0")
map("n", "L", "$")

map("n", "<leader>\\", "<C-w>v", { desc = "split window as |" })
map("n", "<leader>-", "<C-w>s", { desc = "split window as -" })
map("n", "<leader>=", "<C-w>=", { desc = "resize split window" })
map("n", "<leader>qq", "<cmd> q <CR>", { desc = "quit" })
map("n", "<leader>wq", "<cmd> wq <CR>", { desc = "save & quit" })
map("n", "<leader>fs", "<cmd> w <CR>", { desc = "save" })
map("n", "<leader>cd", "<cmd> :ProjectRoot <CR>", { desc = "switch projectRoot" })

-- telescope
map("n", "<leader>l", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live grep" })
map("n", "<leader>b", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find buffers" })
map("n", "<leader>m", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Find oldfiles" })
map("n", "<leader>ft", "<cmd>Telescope terms<CR>", { desc = "Telescope Pick hidden term" })
map("n", "<leader>o", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "Telescope Find command history" })
map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Telescope Find current buffer" })

map("t", "<esc>", "<C-\\><C-n>", { desc = "exit term" })

-- nvimtree
map("n", "<A-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })

map("n", "<leader>1", "1gt")
map("n", "<leader>2", "2gt")
map("n", "<leader>3", "3gt")
map("n", "<leader>4", "4gt")
map("n", "<leader>5", "5gt")

-- Disable mappings
local nomap = vim.keymap.del
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap("n", "<leader>n")
nomap("n", "<C-n>")
nomap("n", "<leader>ch")
nomap("n", "<leader>cm")
