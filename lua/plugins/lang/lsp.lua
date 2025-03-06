local lsp_servers = {
    lua_ls = require 'custom.Lang.lsp.lua_ls',
    clangd = require 'custom.Lang.lsp.clangd',
}

-- INFO: mason_ensure_installed
local mason_ensure_installed = {
    'stylua',
    'lua-language-server',
}

return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
        -- 自动将LSP和相关工具安装到nvim的stpath
        { 'williamboman/mason.nvim', opts = { ui = { border = vim.g.borderStyle, backdrop = 100 } } }, --WARN: 必须在依赖之前加载
        { 'williamboman/mason-lspconfig.nvim' },
        { 'folke/snacks.nvim' },
        {'saghen/blink.cmp'},
    },
    config = function()
        -- INFO: 使用'tiny-inline-diagnostic'禁用诊断
        require 'custom.Lang.diagnostic'
        -- INFO: lsp相关的自动命令和键位映射 
        require 'custom.Lang.lspAttach'

        local lspconfig = require 'lspconfig'
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = vim.tbl_deep_extend(
            'force',
            capabilities,
            require('blink.cmp').get_lsp_capabilities {
                textDocument = { completion = { completionItem = { snippetSupport = false } } },
            }
        )

        for server_name, server_opts in pairs(lsp_servers) do
            server_opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server_opts.capabilities or {})
            server_opts.handlers = vim.tbl_deep_extend('force', {}, server_opts.handlers or {})
            lspconfig[server_name].setup(server_opts)
        end
        vim.cmd 'LspStart'
    end
}