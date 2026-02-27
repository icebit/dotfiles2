return {
    {
        "stevearc/conform.nvim",
        lazy = false,
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    html = { "prettier" },
                    css = { "prettier" },
                    scss = { "prettier" },
                    markdown = { "prettier" },
                    lua = { "stylua" },
                    python = { "black" },
                    go = { "gofumpt", "goimports" },
                    rust = { "rustfmt" },
                },
                format_on_save = false,
            })

            vim.keymap.set({ "n", "v" }, "<leader>lf", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "Format file or range" })
        end,
    },
}
