local max = vim.api.nvim_win_get_width(0)

return function(_, opts)
    vim.cmd 'highlight link BlinkCmpMenuBorder Label'
    vim.cmd 'highlight link BlinkCmpDocBorder Label'
    vim.cmd 'highlight link BlinkCmpSignatureHelpBorder Label'

    opts.signature = {
        enabled = true,
        window = {
            border = vim.g.borderStyle,
        },
    }
    opts.cmdline = {
        enabled = false,
    }
    opts.keymap = {
        ['<C-i>'] = { 'show', 'hide', 'fallback' },
        ['<C-->'] = { 'hide_documentation', 'show_documentation', 'fallback' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
        ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
        ['<C-j>'] = { 'select_and_accept' },
        ['<CR>'] = { 'select_and_accept', 'fallback' },
        ['<Tab>'] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          'snippet_forward',
          'fallback',
        },
        ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
        ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    }
    opts.snippets = {
        preset = 'luasnip',
    }
    opts.appearance = {
        kind_icons = {
            Text = '󰉿 ',
            Method = '󰆧 ',
            Function = '󰊕 ',
            Constructor = ' ',
            Field = '󰜢 ',
            Variable = '󰀫 ',
            Property = '󰜢 ',
            Class = '󰠱 ',
            Interface = ' ',
            Struct = '󰙅 ',
            Module = ' ',
            Unit = '󰑭 ',
            Value = '󰎠 ',
            Enum = ' ',
            EnumMember = ' ',
            Keyword = '󰌋 ',
            Constant = '󰏿 ',
            Snippet = ' ',
            Color = '󰏘 ',
            File = '󰈙 ',
            Reference = '󰈇 ',
            Folder = '󰉋 ',
            Event = ' ',
            Operator = '󰆕 ',
            TypeParameter = '󰬛 ',
        },
    }
    opts.completion = {
        list = {
            cycle = { from_bottom = false, from_top = false },
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },
        keyword = { range = 'full' },
        accept = { auto_brackets = { enabled = true } },
        menu = {
            scrollbar = false,
            border = vim.g.borderStyle,
            auto_show = true,
            draw = {
                align_to = 'cursor',
                columns = {
                    { 'kind_icon', 'label' },
                    { 'kind' },
                },
                components = {
                    label = {
                        width = { fill = true, max = math.ceil(max * 0.25) },
                    },
                    kind = {
                        ellipsis = true,
                        width = { fill = false },
                    },
                    label_description = {
                        width = { max = 10 },
                        text = function(ctx)
                            return ctx.label_description
                        end,
                        highlight = 'BlinkCmpLabelDescriptopn',
                    },
                },       
            },
        },

        -- 选择完成项时显示文档
        documentation = {
           window = {
            max_width = math.ceil(max * 0.6),
            max_height = 10,
            border = vim.g.borderStyle,
            scrollbar = false,
           },
           auto_show = true,
           auto_show_delay_ms = 500,
        },
        -- 在当前行显示所选项目的预览
        ghost_text = { enabled = false },
    }
    opts.sources = {
        default = { 'lsp', 'path', 'buffer' },
        providers = {
            lsp = {
                score_offset = 250,
            },
        },
   }
end