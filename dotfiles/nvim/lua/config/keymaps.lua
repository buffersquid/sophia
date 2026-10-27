local map = vim.keymap.set

vim.g.mapleader = " "

map("n", "<leader>w", "<cmd>write<cr>", {
    desc = "Write buffer",
})

map("n", "<leader>q", "<cmd>copen<cr>", {
    desc = "Open quickfix",
})

map("n", "]q", "<cmd>cnext<cr>", {
    desc = "Next quickfix item",
})

map("n", "[q", "<cmd>cprev<cr>", {
    desc = "Previous quickfix item",
})
