-- 彩虹括号
return {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
    config = function()
        require('rainbow-delimiters.setup').setup {
            highlight = {
                'RainbowDelimiterRed',
                'RainbowDelimiterYellow' --对应二级括号
                'RainbowDelimiterBule',
                'RainbowDelimiterOrange',
                'RainbowDelimiterGreen',
                'RainbowDelimiterViolet',
                'RainbowDelimiterCyan',
            },
        }
    end,
}