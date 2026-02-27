return {
    'ribru17/bamboo.nvim',
    priority = 1000,
    config = function()
        require('bamboo').setup {
            -- optional configuration here
        }
        require('bamboo').load()
        vim.cmd("colorscheme bamboo")
    end,
}
