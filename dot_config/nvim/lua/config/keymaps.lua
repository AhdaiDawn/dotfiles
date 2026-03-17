local map = vim.keymap.set

-- Line movement (soft wrap fix)
map("n", "j", "gj")
map("n", "k", "gk")

map("i", "<C-e>", "<End>")
map("i", "<C-a>", "<Home>")

-- Splits & Windows
map("n", "<leader>\\", "<C-w>v", { desc = "split window as |" })
map("n", "<leader>-", "<C-w>s", { desc = "split window as -" })

-- Resize window
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Split Navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- Buffer navigation
map("n", "H", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "L", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Delete Buffer" })

-- Buffer jump (1-9)
for i = 1, 9 do
	map("n", "<leader>" .. i, function()
		require("bufferline").go_to_buffer(i, true)
	end, { desc = "Go to buffer " .. i })
end

-- Quickfix
map("n", "<leader>qf", "<cmd>copen<cr>", { desc = "Open Quickfix" })
map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- Clipboard
map("v", "<leader>P", [["_dP]], { desc = "Paste without yank" })
map("v", "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yank" })

-- Move line
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- File operations
map("n", "<leader>fs", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Quit
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save & quit" })
map("n", "<leader>q!", "<cmd>q!<cr>", { desc = "Quit without save" })
