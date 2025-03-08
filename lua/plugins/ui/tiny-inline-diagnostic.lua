-- 代码提示(警告、报错提示)
return {
	'rachartier/tiny-inline-diagnostic.nvim',
	event = 'VeryLazy',
	priority = 3000,
	branch = 'main',
	init = function()
		vim.diagnostic.config {
			virtual_text = false,
			update_in_insert = false,
			virtual_lines = {
				highlight_whole_line = false,
			},
		}
	end,
	config = function()
		require('tiny-inline-diagnostic').setup {
			preset = 'modern',
			hi = {
				error = 'DiagnosticError',
				warn = 'DiagnosticWarn',
				info = 'DiagnosticInfo',
				hint = 'DiagnosticHint',
				arrow = 'NonText',
				background = 'CursorLine',
				mixing_color = 'CursorLine',
			},
			options = {
				throttle = 0,
				softwrap = 30,
				multiple_diag_under_cursor = true,
				multilines = true,
				show_all_diags_on_cursorline = true,
				enable_on_insert = true
			},
		}
	end,
}
