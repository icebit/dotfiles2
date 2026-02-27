return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Install parsers (no-op if already installed)
    require("nvim-treesitter").install({
      "lua", "vim", "vimdoc",
      "typescript", "javascript", "tsx",
      "go", "python",
      "json", "yaml", "html", "css", "markdown", "bash",
    })

    -- Enable highlighting and indentation per filetype
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local bufname = vim.api.nvim_buf_get_name(ev.buf)
        if bufname:match("^term://") then return end

        local ok, stats = pcall(vim.uv.fs_stat, bufname)
        if ok and stats and stats.size > 100 * 1024 then return end

        pcall(vim.treesitter.start)
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
