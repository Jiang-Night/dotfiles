return {
   'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
        background = { light = "latte", dark = "mocha" },
        term_colors = false,
        transparent_background = true,
        integrations = {
            cmp = true,
            blink_cmp = true,
            nvimtree = true,
            treesitter = true,
            mason = true,
            rainbow_delimiters = true,
            dropbar = {
                enabled = true,
                color_mode = true,
            },
            symbols_outline = true,
            lsp_trouble = true,
            which_key = true,
        },
        styles = {
            comments = { 'italic' },
            conditionals = { 'italic' },
            functions = { 'italic' },
            keywords = { 'italic' ,"bold" },
            booleans = { 'italic' },
            loops = {},
            strings = {},
            variables = {},
            numbers = {},
            properties = {},
            types = {},
            operators = {},
        },
        highlight_overrides = {
            mocha = function(mocha)
                return {
                    DiagnosticUnderlineError = { undercurl = true,sp = mocha.red },
                    DiagnosticUnderlineWarn = { undercurl = true,sp = mocha.yellow },
                    DiagnosticUnderlineInfo = { undercurl = true,sp = mocha.green },
                    DiagnosticUnderlineHint = { undercurl = true,sp = mocha.sky },
                }
            end,
        },
    },
}