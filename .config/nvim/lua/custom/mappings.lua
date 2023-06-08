local M = {}

M.general = {
  i = {
    ["<C-f>"] = { "<Right>", "move right" },
  },
  n = {
    -- splits windows
    ["<leader>\\"] = { "<C-w>v", "split window as |" },
    ["<leader>-"] = { "<C-w>s", "split window as -" },
    ["<leader>w="] = { "<C-w>=", "resize split window" },

    ["<leader>qq"] = { "<cmd> q <CR>", "quit" },
    ["<leader>wq"] = { "<cmd> wq <CR>", "save & quit" },
    ["<leader>fs"] = { "<cmd> w <CR>", "save" },
    ["<leader>cd"] = { "<cmd> :ProjectRoot <CR>", "switch projectRoot" },
  },
  t = {
    ["<esc>"] = { "<C-\\><C-n>", "exit term" },
  },
}

M.nvimtree = {
  n = {
    -- toggle
    ["<leader>n"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },
  },
}

M.telescope = {
  n = {
    -- find
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "find files" },
    ["<leader>fc"] = { "<cmd> Telescope command_history <CR>", "find files" },
    ["<leader>l"] = { "<cmd> Telescope live_grep <CR>", "live grep" },
    ["<leader>b"] = { "<cmd> Telescope buffers <CR>", "find buffers" },
    ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "help page" },
    ["<leader>m"] = { "<cmd> Telescope oldfiles <CR>", "find oldfiles" },
    ["<leader>fk"] = { "<cmd> Telescope keymaps <CR>", "show keys" },
    -- pick a hidden term
    ["<leader>ft"] = { "<cmd> Telescope terms <CR>", "pick hidden term" },
  },
}

M.lspconfig = {
  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },
  },
}
return M
