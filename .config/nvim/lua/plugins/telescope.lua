return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
      }
    },
    config = function()
      local telescope = require('telescope')
      local builtin = require('telescope.builtin')

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            ".cache/",
            "%.lock"
          },
        },
        pickers = {
          find_files = {
            hidden = true,
          },
        },
      })

      telescope.load_extension('fzf')

      -- File pickers
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set('n', '<leader>fc', builtin.colorscheme, { desc = "Colorschemes" })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Keymaps" })

      -- Git pickers
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "Git files" })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits" })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git status" })

      -- Search pickers
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = "Search word under cursor" })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = "Search by grep" })
      vim.keymap.set('n', '<leader>sl', builtin.current_buffer_fuzzy_find, { desc = "Search lines in current buffer" })
      vim.keymap.set('n', '<leader>sL', builtin.live_grep, { desc = "Search lines in all buffers" })

      -- Command pickers
      vim.keymap.set('n', '<leader>:', builtin.commands, { desc = "Commands" })
      vim.keymap.set('n', '<leader>;', builtin.command_history, { desc = "Command history" })
      vim.keymap.set('n', '<leader>/', builtin.search_history, { desc = "Search history" })

      -- LSP pickers
      vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions, { desc = "LSP definitions" })
      vim.keymap.set('n', '<leader>lr', builtin.lsp_references, { desc = "LSP references" })
      vim.keymap.set('n', '<leader>li', builtin.lsp_implementations, { desc = "LSP implementations" })
      vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, { desc = "Document symbols" })
      vim.keymap.set('n', '<leader>lS', builtin.lsp_workspace_symbols, { desc = "Workspace symbols" })

      -- Diagnostics
      vim.keymap.set('n', '<leader>dd', builtin.diagnostics, { desc = "Diagnostics" })

      -- Backwards compatibility
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = "Git files" })
    end
  }
}