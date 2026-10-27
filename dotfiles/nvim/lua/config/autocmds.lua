local group = vim.api.nvim_create_augroup("user-autocmds", {
    clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})
