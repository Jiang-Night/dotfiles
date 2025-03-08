-- git相关
return {
	{
		'lewis6991/gitsigns.nvim',
		event = 'VeryLazy',
		opts = {
			signs = {
				add = { text = '┃' },
				change = { text = '┃' },
				delete = { text = '┃' },
				topdelete = { text = '┃' },
				changedelete = { text = '┃' },
			},
			on_attach = function(bufnr) -- 当插件加载到缓冲区时执行的函数
				local gitsigns = require 'gitsigns'
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation 导航
				map('n', ']c', function()  -- 定义导航到下一个更改块的快捷键
					if vim.wo.diff then    --如果处于diff模式
						vim.cmd.normal { ']c', bang = true } --执行diff模式下的跳转命令
					else
						gitsigns.nav_hunk 'next' --否则使用gitsigns导航到下一个更改块
					end
				end, { desc = 'Jump to next git [c]hange' })

				map('n', '[c', function()
					if vim.wo.diff then -- 如果处于diff模式
						vim.cmd.normal { '[c', bang = true }
					else
						gitsigns.nav_hunk 'prev'
					end
				end, { desc = 'Jump to previous git [c]hange' })

				-- Actions操作
				map('v', '<leader>gs', function()             -- 可视模式下，暂存更改块
					gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } --暂存当前可视选择的更改块
				end, { desc = '[S]tage git hunk' })

				map('v', '<leader>gr', function() -- 重置更改块
					gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
				end, { desc = '[R]eset git hunk' })

				map('n', '<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' }) -- 暂存更改块
				map('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' }) -- 重置更改块
				map('n', '<leader>gS', gitsigns.stage_buffer, { desc = 'git [s]tage buffer' }) -- 暂存更改块
				map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' }) -- 撤销暂存区更改
				map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git [r]eset buffer' }) -- 重置整个缓存区
				map('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' }) -- 预览更改块
				map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' }) -- 查看当前行的blame信息
				map('n', '<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff ageinst index' }) -- 与索引来进行diff比较
				map('n', '<leader>gD', function()
					gitsigns.diffthis '@'                                                --使用@符号表示最后一次提交
				end, { desc = 'git [D]iff against last commit' })                        -- 与最后一次提交进行diff比


				-- Toggles
				map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line ' }) -- 切换当前行的blame显示
				map('n', '<leader>gtD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' }) --切换显示已删除的行
			end,
		},
	},
}
