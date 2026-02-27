return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Prevent invalid window errors
    vim.api.nvim_create_autocmd({"BufWinLeave", "WinClosed"}, {
      callback = function()
        local ft = vim.bo.filetype
        if ft == "NvimTree" or ft == "TelescopePrompt" then
          return
        end
        pcall(vim.treesitter.stop)
      end,
    })

    -- Additional telescope-specific fix
    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopePreviewerLoaded",
      callback = function()
        pcall(function()
          vim.wo.conceallevel = 0
        end)
      end,
    })

    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "typescript",
        "javascript",
        "tsx",
        "go",
        "python",
        "json",
        "yaml",
        "html",
        "css",
        "markdown",
        "bash",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = function(lang, buf)
          -- Disable for terminal buffers
          local bufname = vim.api.nvim_buf_get_name(buf)
          if bufname:match("^term://") then
            return true
          end

          -- Disable for telescope preview windows
          local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
          if buftype == 'nofile' or buftype == 'prompt' then
            return true
          end

          -- Disable for large files
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, bufname)
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },
      indent = {
        enable = true,
      },
    })
  end,
}