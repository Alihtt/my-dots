require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

map("v", "<S-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "<S-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
map("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
