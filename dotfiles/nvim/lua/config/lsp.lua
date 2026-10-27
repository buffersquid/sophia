vim.diagnostic.config({
    severity_sort = true,
    underline = true,
    virtual_text = {
        spacing = 2,
        source = "if_many",
    },
    float = {
        border = "rounded",
        source = "if_many",
    },
})

local group = vim.api.nvim_create_augroup("user-lsp", {
    clear = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(ev)
        local bufnr = ev.buf

        local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, {
                buffer = bufnr,
                desc = desc,
            })
        end

        map("gd", vim.lsp.buf.definition, "Go to definition")
        map("gr", vim.lsp.buf.references, "Find references")
        map("gI", vim.lsp.buf.implementation, "Go to implementation")
        map("K", vim.lsp.buf.hover, "Hover documentation")

        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>dd", vim.diagnostic.open_float, "Show diagnostics")

        map("[d", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, "Previous diagnostic")

        map("]d", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, "Next diagnostic")

        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client and client:supports_method(
            "textDocument/completion", bufnr
        ) then
            vim.lsp.completion.enable(
                true,
                client.id,
                bufnr,
                { autotrigger = true }
            )
        end
    end,
})
