-- 彩虹括号
return {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
    config = function()
        require('rainbow-delimiters.setup').setup {
            highlight = {
                'RainbowDelimiterRed',
                'BufferLinePick' --对应二级括号，红色高亮组
                'RainbowDelimiterBule',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
    end,
}