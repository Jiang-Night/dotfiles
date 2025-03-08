local lualine = require 'lualine'
local separatirs = require('custom.Lualine.chars').separators
local spinner_chars = require('custom.Lualine.chars').spinner_char

local left_separators = separatirs.left_rounded
local right_separators = separatirs.right_rounded

local function scroll_bar()
	local chars = setmetatable(spinner_chars, {
		__index = function()
			return ''
		end,
	})
	local line_ratio = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
	local position = math.floor(line_ratio * 100)
	local icon = chars[math.floor(line_ratio * #chars)] .. position
	if position <= 10 or vim.api.nvim_win_get_cursor(0)[1] == 1 then
		return ' TOP'
	elseif (vim.api.nvim_buf_line_count(0) - vim.api.nvim_win_get_cursor(0)[1]) == 0 then
		return ' BOT'
	else
		return string.format('%s', icon) .. '%%'
	end
end

local function scroll_bar_hl()
	local position = math.floor(vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0) * 100)
	local fg
	if position <= 10 or vim.api.nvim_win_get_cursor(0)[1] == 1 then
		fg = '#5adaff'
	elseif (vim.api.nvim_buf_line_count(0) - vim.api.nvim_win_get_cursor(0)[1]) == 0 then
		fg = '#ff6d36'
	else
		fg = '#D3D3D3'
	end
	return { fg = fg }
end

local function dir_info()
	local current_dir = vim.fn.getcwd()
	local home_dir = vim.fn.expand '~'
	local dir_name = current_dir == home_dir and '~' or vim.fn.fnamemodify(current_dir, ':t')
	return vim.api.nvim_win_get_width(0) < 110 and string.format('%s', '󰉖') or string.format('%s %s', '󰉖', dir_name)
end

local function lsp_info()
	local msg = require('lsp-progress').progress()
	return msg
end

local function file_info()
	local filename = vim.fn.expand '%:t'
	local extension = vim.fn.expand '%:e'
	local present, isons = pcall(require, 'nvim-web-devicons')
	local icon = present and icons.get_icon(filename, extension) or '󰈙 '
	if vim.api.nvim_win_get_width(0) < 140 then
		return (vim.bo.modified and '%m' or '') .. ' ' .. icon .. ' '
	end
	return (vim.bo.modified and '%m' or '') .. ' ' .. icon .. ' ' .. filename .. ' '
end


local function search_count()
	local ok, result = pcall(vim.fn.searchcount, { maxcount = 999, timeout = 250 })
	if not ok or not next(result) then
		return ''
	end
	local denominator = math.min(result.total, result.maxcount)
	return string.format(' [%d/%d] ', result.current, denominator)
end

local function micro()
	local recording_register = vim.fn.reg_recording()
	return #recording_register > 0 and string.format(' Recording @%s', recording_register) or ''
end

-- Config
local config = {
	options = {
		disabled_filetyps = {
			'alpha',
			'dashboard',
			'snacks_dashboard',
			'neo-tree',
			'mason',
			'lazy',
			'oil',
			'TelescopePrompt',
			'toggleterm',
			'yazi',
		},
		ignore_focus = { 'neo-tree', 'dashboard', 'snacks_dashboard' },
		theme = 'auto',
		component_separators = '',
		section_separators = '',
	},
	sections = {
		lualine_a = {
			{
				'mode',
				fmt = function(str)
					return vim.api.nvim_win_get_width(0) < 110 and str:sub(1, 1) or string.format('%-8s', str)
				end,
				icon = '󰀘',
				color = { gui = 'bold' },
				separator = { left = left_separators, right = '' },
			},
		},

		lualine_b = {
			{
				'branch',
				icon = { '', align = 'left' },
				separator = { right = right_separators },
				padding = { left = 1 },
			},
			{
				'diff',
				symbols = { added = ' ', modified = ' ', removed = ' ' },
				separator = { right = right_separators },
				padding = { right = 0, left = 1 },
			},
		},

		lualine_c = {
			{ scroll_bar, padding = { right = 0, left = 1 }, color = scroll_bar_hl },
			{
				'location',
				separator = { right = right_separators },
				padding = { left = 1 },
				cond = function()
					return vim.api.nvim_win_get_width(0) > 110
				end,
			},
			{
				search_count,
				cond = function()
					return vim.v.hlsearch ~= 0
				end,
			},
			{ micro },
		},

		lualine_x = {
			{ lsp_info, separator = {} },
		},

		lualine_y = {
			{
				'filename',
				file_status = true,
				newfile_status = false,
				path = 4,
				showrting_target = 40,
				symbols = {
					modifies = '[+]',
					readonly = '[-]',
					unnamed = '[None]',
					newfile = '[New]',
				},
				fmt = function(name)
					local present, icons = pcall(require, 'nvim-web-devicons')
					local icon = present and icons.get_icon(name) or '󰈙 '
					return name
				end,

				separator = { left = left_separators, right = right_separators },
			},
		},

		lualine_z = {
			{
				dir_info,
				separator = { right = right_separators },
				color = { gui = 'bold' },
			},
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

local function ins_right(component)
	table.insert(config.sections.lualine_c, component)
end

ins_right {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = '  ', warn = '  ', info = '  ', hint = '  ' },
	cond = function()
		local diagnostics = vim.diagnostic.get(0)
		local count = 0
		for _ in ipairs(diagnostics) do
			count = count + 1
		end
		return count ~= 0
	end,
}

lualine.setup(config)
