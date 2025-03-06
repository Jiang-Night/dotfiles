--INFO: treesitter ensure_installed
local ensure_installed = {
	'lua',
	'vim',
	'c',
	'json',
	"rust",
	"yaml",
	"ini",
	"markdown",
}
return { -- 高亮显示，编辑和导航代码
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	main = 'nvim-treesitter.config', -- 设置用于opts的主模块
	-- [[配置 Treesitter]]参见 ':help nvim-treesotter'
	config = function()
		require('nvim-treesitter.configs').setup {
			modules = {},
			ensure_installed = ensure_installed,
			-- Install parsers synchronously (only applied to `ensure_installed`)
			sync_install = false,
			-- Automatically install missing parsers when entering buffer
			auto_install = true,
			-- List of parsers to ignore installing (for "all")
			ignore_install = { 'tmux' },
			-- 支持语言
			-- 启用代码高亮
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			-- 启用增量选择
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = '<CR>',
					node_incremental = '<CR>',
					node_decremental = '<BS>',
					scope_incremental = '<TAB>',
				},
			},
			-- 启用基于Treesitter的代码格式化(=)
			indent = {
				enable = false,
			},
		}
		-- 开启代码折叠
		vim.opt.foldmethod = 'expr'
		vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		-- 默认不折叠
		-- vim.wo.foldlevel = 99
	end,
}
