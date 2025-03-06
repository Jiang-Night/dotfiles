return {
    {
        -- lazydev 配置你的nvim配置，运行时和插件的lua lsp
        -- 用于nvim api的补全、注释、签名
        'folke/lazydev.nvim',
        event = 'VeryLazy',
        ft = 'lua',
        opts = {
            library = {
                { path = 'snacks.nvim', words = { 'Snacks' } },
                { path = 'lazy.nvim', words = { 'Lazy' } },
                { path = 'mini.files', words = { 'MiniFiles' } },
                -- 当发现 'vim.uv'单词时，加载luvit类型
                { path = 'luvit-meta/library', words = { 'vim%.uv', 'vim%.loop' } },
            },
        },
    },
    { 'Bilal2453/luvit-meta', lazy = true },
}