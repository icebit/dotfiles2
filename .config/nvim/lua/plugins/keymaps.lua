return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local wk = require("which-key")
            wk.setup({})

            -- System clipboard
            vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
            vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
            vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

            -- File reload
            vim.keymap.set("n", "<leader>rr", ":checktime<CR>", { desc = "Reload current file" })
            vim.keymap.set("n", "<leader>ra", ":bufdo checktime<CR>", { desc = "Reload all files" })

            -- Which-key group definitions
            wk.add({
                -- File operations
                { "<leader>f",  group = "Find" },
                { "<leader>ff", desc = "Find files" },
                { "<leader>fg", desc = "Live grep" },
                { "<leader>fb", desc = "Find buffers" },
                { "<leader>fh", desc = "Help tags" },
                { "<leader>fr", desc = "Recent files" },
                { "<leader>fc", desc = "Colorschemes" },
                { "<leader>fk", desc = "Keymaps" },

                -- Explorer operations
                { "<leader>e",  group = "Explorer" },
                { "<leader>e",  desc = "Toggle file explorer" },
                { "<leader>ef", desc = "Find file in explorer" },
                { "<leader>ec", desc = "Collapse file explorer" },
                { "<leader>er", desc = "Refresh file explorer" },

                -- Reload operations
                { "<leader>r",  group = "Reload" },
                { "<leader>rr", desc = "Reload current file" },
                { "<leader>ra", desc = "Reload all files" },

                -- Git operations
                { "<leader>g",  group = "Git" },
                { "<leader>gf", desc = "Git files" },
                { "<leader>gc", desc = "Git commits" },
                { "<leader>gs", desc = "Git status" },

                -- Search operations
                { "<leader>s",  group = "Search" },
                { "<leader>sw", desc = "Search word under cursor" },
                { "<leader>sg", desc = "Search by grep" },
                { "<leader>sl", desc = "Search lines in current buffer" },
                { "<leader>sL", desc = "Search lines in all buffers" },

                -- LSP operations
                { "<leader>l",  group = "LSP" },
                { "<leader>lf", desc = "Format buffer" },
            })
        end,
    }
}

