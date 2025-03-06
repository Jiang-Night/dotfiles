local formaters = {
    lua = { 'stylua' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    json = { 'fixjson' },
    jsonc = { 'fixjson' },
    zsh = { 'beautysh' },
    shell = { 'beautysh' },
}
return { --AutoFormat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>lf',
            function()
                require('conform').format { async = true, lsp_format = 'fallback' }
            end,
            mode = '',
            desc = '[F]ormat buffer',
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = {
            lsp_format = 'fallbacl',
            timeout_ms = 500,
        },
        formattters_by_ft = formaters,
    },
}