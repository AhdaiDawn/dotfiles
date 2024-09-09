require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("i", "<C-f>", "<Right>", { desc = "move right" })

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
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "<leader>fc", "<cmd>Telescope command_history<cr>", { desc = "Telescope Find command history" })

map("t", "<esc>", "<C-\\><C-n>", { desc = "exit term" })

-- nvimtree
map("n", "<A-n>", "<cmd>NvimTreeToggle<CR>", { desc = "nvimtree toggle window" })
