local M = {}
M.options = {
	win = {
		input = {
			keys = { ['<a-a>'] = 'cycle_win', mode = { 'i', 'n' } },
		},
		list = {
			keys = { ['a-a'] = 'cycle_win' },
		},
		preview = {
			keys = {
				['Esc'] = 'close',
				['q'] = 'close',
				['i'] = 'focus_input',
				['ScrollWheelDown'] = 'list_scroll_wheel_down',
				['ScrollWheelUp'] = 'list_scroll_wheel_up',
				['<a-a>'] = 'cycle_win',
			},
		},
	},
}
M.keys = {
	{ '<leader>ft', function() Snacks.picker.colorschemes() end,                          desc = 'Colorschemes' },
	{ '<leader>fn', function() Snacks.picker.smart { cwd = vim.fn.stdpath 'config' } end, desc = 'Smart Find Nvim Config' },
	{'<leader>fh', function() Snacks.picker.help() end, desc = 'Help Pages' },
	{ '<leader>fk', function() Snacks.picker.keymaps() end, desc = 'keymaps' },
	{ '<leader>ff', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
	{ '<leader>fb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
	{ '<leader>fl', function() Snacks.picker.lines() end, desc = 'Buffer Lines' },
	{ '<leader>fg', function() Snacks.picker.grep() end, desc = 'Grep' },
	{ '<leader>fw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },
	{ '<leader>fB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
	{ '<leader>f.', function() Snacks.picker.resume() end, desc = 'Recent' },
	{ '<leader>fr', function() Snacks.picker.recent() end, desc = 'Recent' },
	{ '<leader>fD', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics' },
	{ '<leader>fd', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics' },
    {
		'<leader>fc',
		function()
			Snacks.picker.cliphist {
				layout = {
					layout = {
						box = 'vertical',
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.4,
						border = 'top',
						title = ' {title} {live} {flags}',
						title_pos = 'left',
						{ win = 'input', height = 1, border = 'bottom' },
						{
							box = 'horizontal',
							{ win = 'list',    border = 'none' },
							{ win = 'preview', title = '{preview}', width = 0.6, border = 'left' },
						},
					},
				},
			}
		end,
		desc = 'Cliphist',
	},
}
return M
