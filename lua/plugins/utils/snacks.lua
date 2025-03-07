-- 终端、消息通知、文件浏览器、模糊查找等
-- 详见:https://www.github.com/folke/snacks.nvim
return {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = {},
        animate = { enabled = false },
        bufferdelete = {},
        image = {},
        quickfile = {},
        scroll = { enabled = false },
        terminal = require 'custom.Snacks.terminal', -- 终端
        notifier = {},
        scope = {enabled = false},
        explorer = { replace_netrw = true },
        dashboard = require 'custom.Snacks.dashboard', -- 欢迎界面
        picker = require 'custom.Snacks.picker' ,
        indent = {},
        statuscolumn = {},
        styles = {
            notification = {
                border = vim.g.borderStyle,
                zindex = 100,
                ft = 'markdown',
                wo = {
                    winblend = 5,
                    wrap = false,
                    conceallevel = 2,
                    colorcolumn = '',
                },
                bo = { filetype = 'snacks_notify' },
            },
        },
    },
    keys = vim.list_extend(require('custom.Snacks.picker').keys,{
        {
            '<leader>t',
            function()
                Snacks.terminal.toggle '/bin/zsh'    
            end,
            mode = { 'n', 'i', 'v', 't' },
            { decs = 'Toggle Float Terminal' },
        },
    }),
}