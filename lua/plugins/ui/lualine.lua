local lsp_progress_config = require 'custom.Lualine.lsp_progress'
return {
	'nvim-lualine/lualine.nvim',
	event = 'VeryLazy',
	init = function()
		vim.g.lualine_laststatus = vim.o.laststatus
		if vim.fn.argc(-1) > 0 then
			vim.o.statusline = ' '
		else
			vim.o.laststatus = 0
		end
	end,
	dependencies = {
		'nvim-tree/nvim-web-devicons',
		{
			'linrongbin16/lsp-progress.nvim',
			event = 'VimEnter',

			config = function()
				require('lsp-progress').setup(lsp_progress_config)
			end,
		},
	},
	config = function()
		require 'custom.Lualine.lualine'
	end
}
