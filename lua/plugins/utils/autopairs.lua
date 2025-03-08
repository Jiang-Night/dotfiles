-- 自动补全括号等
return {
    'windwp/nvim-autopairs',
    event = 'InserEnter',
    config = function()
        require('nvim-autopairs').setup { map_cr = true }
    end,
}