local spinner_char = require('custom.Lualine.chars').spinner_char
return {
	spinner = spinner_char,
	client_format = function(_, spinner, series_messages)
		return #series_messages > 0 and (spinner .. 'LSP') or '󰅡 Lsp'
	end,
	format = function(client_messages)
		if #client_messages > 0 then
			return table.concat(client_messages)
		end
		if #vim.lsp.get_clients() > 0 then
			return string.format('󰅡%s', 'Lsp')
		end
		return '󱏎Lsp'
	end
}
