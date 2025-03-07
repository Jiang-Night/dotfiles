
-- 设置<space>为leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- 在终端中安装并选择了 Nerd Font，则设置为 true
vim.g.have_nerd_font = true

-- [[ 设置选项 ]]

-- 设置行号
vim.opt.number = true

-- 启用鼠标模式
vim.opt.mouse = 'a'

-- 不显示模式，因为它已经在状态行中
vim.opt.showmode = false

-- 操作系统和nvim同步剪切板
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- 启用中断缩进
vim.opt.breakindent = true

-- 保存撤销历史记录
vim.opt.undofile = true

-- 不区分大小写搜索 除非搜索词中有 \C 或一个或多个大写字母
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- 默认保持 signcolumn 处于开启状态
vim.opt.signcolumn = 'yes'

-- 减少更新时间
vim.opt.updatetime = 250

-- 减少映射序列等待时间
vim.opt.timeoutlen = 300

-- 配置如何打开新的拆分
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 设置 nvim 在编辑器中如何显示某些空白字符
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- 输入时实时预览替换
vim.opt.inccommand = 'split'

-- 显示光标位于哪一行
vim.opt.cursorline = true

-- 保持在光标上方和下方的最小屏幕线数
vim.opt.scrolloff = 10