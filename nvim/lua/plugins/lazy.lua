local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

-- 使用 `opts = {}` 自动将选项传递给插件的 `setup()` 函数，强制加载插件
-- 或者，使用 `config = function() ... end` 来完全控制配置
require('lazy').setup({
    'tpope/vim-sleuth',
-- Alternatively, use `config = function() ... end` for full control over the configuration.
-- If you prefer to call `setup` explicitly, use:
--    {
--        'lewis6991/gitsigns.nvim',
--        config = function()
--            require('gitsigns').setup({
--                -- Your gitsigns configuration here
--            })
--        end,
--    }
--
-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`.
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        },
      },
    },

    {
        'folke/which-key.nvim',
        event = 'VimEnter', -- Sets the loading event to 'VinEnter'
        opts = {
            -- 按下某个键和打开哪个键之间的延迟（毫秒）
            delay = 0,
            icons = {
                mappings = vim.g.have_nerd_font,
                -- 如果不是nerd字体就运行{} 如果是就运行or后的
                keys = vim.g.have_nerd_font and {} or {
                    Up = '<Up> ',
                    Down = '<Down >',
                    Left = '<Left >',
                    Right = '<Right >',
                    C = '<C-…> ',
                    M = '<M-…> ',
                    D = '<D-…> ',
                    S = '<S-…> ',
                    CR = '<CR> ',
                    Esc = '<Esc> ',
                    ScrollWheelDown = '<ScrollWheelDown> ',
                    ScrollWheelUp = '<ScrollWheelUp> ',
                    NL = '<NL> ',
                    BS = '<BS> ',
                    Space = '<Space> ',
                    Tab = '<Tab> ',
                    F1 = '<F1>',
                    F2 = '<F2>',
                    F3 = '<F3>',
                    F4 = '<F4>',
                    F5 = '<F5>',
                    F6 = '<F6>',
                    F7 = '<F7>',
                    F8 = '<F8>',
                    F9 = '<F9>',
                    F10 = '<F10>',
                    F11 = '<F11>',
                    F12 = '<F12>',
                },
            },
            spec = {
                { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
                { '<leader>d', group = '[D]ocument' },
                { '<leader>r', group = '[R]ename' },
                { '<leader>s', group = '[S]earch' },
                { '<leader>w', group = '[W]orkspace' },
                { '<leader>t', group = '[T]oggle' },
                { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },        
            },
        },
    },
    { -- 模糊查找器（文件、lsp 等）
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
            { 'nvim-telescope/telescope-ui-select.nvim' },
            { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        config = function()
        -- Telescope是一个模糊查找器
        -- 它可以搜索neovim 工作区 lsp等不同的东西
        -- :Telescope help tags
        -- 插入模式：<c-/>
        -- 正常模式：？
        -- [[ Configure Telescope ]]
        require('telescope').setup {
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }
        -- 如果安装了telescope扩展，启用
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags,{ desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

        -- 搜索当前工作区
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, {desc = '[/] Fuzzily search in current buffer' })

        -- 搜索文件
        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files'})
        
        -- 搜索nvim配置文件快捷方式
        vim.keymap.set('n', '<leader>sn', function()
          builtin.find_files { cwd = vim.fn.stdpach 'config' }
        end, {desc = '[S]earch [N]eovim files' })
    end,
    },

    -- LSP Plugins
    {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = {
            library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- NOTE：`opts = {}` 与调用 `require('mason').setup({})` 相同
            { 'williamboman/mason.nvim', opts = {} },
            'williamboman/mason-lspconfig.nvim',
            'WhoIsSethDaniel/mason-tool-installer.nvim',

            { 'j-hui/fidget.nvim', opts = {} },
            'hrsh7th/cmp-nvim-lsp',
        },
    config = function()
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true}),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or 'n'
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

            -- 跳转到光标所在单词的定义
            -- 要跳回 使用<C-t>
            map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
            
            -- 查找光标下单词的参考
            map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

            -- 跳转到光标下单词的实现
            map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

            -- 跳转到光标下单词的类型
            map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

            -- 模糊查找当前文档中的所有符号
            map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

            -- 模糊查找当前工作区中的所有符号
            map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

            -- 重命名光标下的变量
            map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

            -- 执行代码操作，通常需要将光标置于错误上方
            map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

            -- 警告：这不是 Goto 定义，而是 Goto 声明。
            map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

            local function client_supports_method(client, method, bufnr)
                if vim.fn.has 'nvim-0.11' == 1 then
                    return client.supports_method(method, bufnr)
                else
                    return client.supports_method(method, { bufnr = bufnr})
                end
            end

            -- 以下两个自动命令用于在光标停留片刻时突出显示光标下方单词的引用
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
                local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight')
                vim.api.nvim_create_augroup({ 'CursorHold', 'CursorHoldI' }, {
                    buffer = event.buf,
                    group = highlight_augroup,
                    callback = vim.lsp.buf.document_highlight,
                })
            
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = highlight_augroup, buffer = event.buf })
                end,
            })
        end

            -- 以下代码会创建一个键映射，用于在您的代码中切换嵌入提示（如果您使用的语言服务器支持它们）
            if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
                map("<leader>th", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf})
                end, "[T]oggle Inlay [H]ints")
            end
        end,
    })

    vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- 在表中添加任何其他覆盖配置，可用键：
      -- cmd(表)：覆盖用于启动服务器的默认命令
      -- filetypes(表)：覆盖服务器的默认关联文件类型类型
      -- capabilities(表)：覆盖功能中的字段，可用于禁用LSP中的某些功能
      -- setting(表)：覆盖初始化服务器时传递的默认设置
      local servers = {
        -- clangd = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- 对于许多设置，LSP('ts_ls')就可以正常工作
        lua_ls = {
            -- cmd = { ... },
            -- filetypes = { ... },
            -- capabilities = {},
            settings = {
                Lua = {
                    complete = {
                        callSnippet = 'Replace',
                    },
                -- 可以在下面切换以忽略 Lua_LS 的嘈杂“missing-fields”警告
                -- diagnostics = { disable = { 'missing-fields' } },
                },
            },
        },
      }

      -- 要检查已安装工具的当前状态和/或手动安装其他工具
      -- :Mason
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- 使用lua格式化
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- 通过 mason-tool-installer 填充安装
        automatic_installation = false,
        handlers = {
            function(server_name)
                local server = servers[server_name] or {}
                -- 这仅处理由上述服务器配置明确传递的值。在禁用 LSP 的某些功能时很有用（例如，关闭 ts_ls 的格式）
                server.capabilities = vim.tbl_deep_extend('force', {},capabilities, server.capabilities or {})
            end,
        },
      }
    end,
},
    { -- Autoformat
        'stevearc/conform.nvim',
        event = { 'BufWritePre' },
        cmd = { 'ConformInfo' },
        keys = {
            {
                '<leader>f',
                function()
                    require('conform').format { async = true, lsp_format = 'fallback' }
                end,
                mode = '',
                desc = '[F]ormat buffer',
            },
        },
        opts = {
            notify_on_error = false,
            format_on_save = function(bufnr)
            local disable_filetypes = { c = true, cpp = true }
            local lsp_format_opt
            if disable_filetypes[vim.bo[bufnr].filetype] then
                lsp_format_opt = 'never'
            else
                lsp_format_opt = 'fallback'
            end
                return {
                    timeout_ms = 500,
                    lsp_format = lsp_format_opt,
                }
            end,
            formatters_by_ft = {
                lua = { 'stylua' },
                -- Conform 还可以按顺序运行多个格式化程序
                -- python = { "isort", "black" },
                -- 您可以使用“stop_after_first”从列表中运行第一个可用的格式化程序
                -- javascript = { "prettierd", "prettier", stop_after_first = true },
            },
        },
    },

    { -- Autocompletion
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                 if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                 end
                 return 'make install_jsregexp'
                end)(),
                dependencies = {

                },
            },
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',      
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            luasnip.config.setup {}

            cmp.setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = 'menu,menuone,noinsert' },
                mapping = cmp.mapping.preset.insert {
                    -- 选择下一个项目
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    -- 选择上一个项目
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    -- 向后滚动文档窗口 [b] / [f] 向前
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    -- 接受（[y]es）完成。
                    ['<C-y>'] = cmp.mapping.confirm { select = true },

                    ['<C-Space>'] = cmp.mapping.complete {},
                    -- <c-l> will move you to the right of each of the expansion locations.
                    -- <c-h> is similar, except moving you backwards.
                    ['<C-l>'] = cmp.mapping(function()
                        if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                        end
                    end, { 'i', 's' }),
                    ['<C-h>'] = cmp.mapping(function()
                        if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                        end
                    end, { 'i', 's' }),
                },
                sources = {
                    {
                        name = 'lazydev',
                        group_index = 0,
                    },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'nvim_lsp_signature_help' },
                },
            }
        end
    },

    {
        -- 如果您想查看已安装的配色方案，可以使用 `:Telescope colorscheme`
        'folke/tokyonight.nvim',
        priority = 1000,
        config = function()
            require('tokyonight').setup {
                styles = {
                    comments = { italic = false }
                },
            }

        vim.cmd.colorscheme 'tokyonight-night'
        end,
    },

    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' },opts = { signs = false } },

    -- 各种小型独立插件/模块的集合
    {
        'echasnovski/mini.nvim',
        config = function()
            require('mini.ai').setup { n_lines = 500 }
            -- 添加/删除/替换周围内容（括号、引号等）
            require('mini.surround').setup()
            -- 简单易用的状态行
            local statusline = require 'mini.statusline'
            statusline.setup { use_icons = vim.g.have_nerd_font }

            statusline.section_location = function()
                return '%2l:%-2v'
            end
        end,
    },

    {
        -- 突出显示、编辑和导航代码
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs',
        opts = {
            ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc'},
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
        indent = { enable = true, disable = { 'ruby' } },
        },
    },
}, {
    ui = {
        icons = vim.g.have_nerd_font and{} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
})