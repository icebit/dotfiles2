return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Disable netrw
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      sort_by = "case_sensitive",
      view = {
        width = 35,
        side = "left",
      },
      renderer = {
        group_empty = true,
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      git = {
        enable = true,
        ignore = false,
      },
      update_cwd = true,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      diagnostics = {
        enable = false,
      },
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Find file in explorer" })
    vim.keymap.set("n", "<leader>ec", ":NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
    vim.keymap.set("n", "<leader>er", ":NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
  end,
}
