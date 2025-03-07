-- 小工具 悬停样式 侧边符号列表等
return {
    'nvimdev/lspsaga.nvim',
    event = 'VeryLazy',
    opts = function(_,opts)
        opts.lightbulb = {
            enable = false,
            sign = false,
            debounce = 10,
            sign_proiority = 40,
            virtual_text = 40,
            enable_in_insert = true,
            ignore = {
                clients = {},
                ft = {},
            },
        }
        opts.hover = {
            max_width = 0.5,
        }
        -- opts.ui = { border = vim.g.borderStyle, kind = require('catppuccin.groups.integrations.lsp.saga').custom_kind() }
        vim.keymap.set('n', '<leader>so', '<cmd>Lspsaga outline<CR>', {desc = '[S]ymbol [O]utline' })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons', -- optional
    }
}