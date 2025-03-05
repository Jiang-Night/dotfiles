require('lazy').setup {
    install = { colorscheme = {'habamax'} },
    spec = {
        -- 通过模块化方式导入插件配置
        { import = 'plugins.lang' },
    },
    git = {
        timeout = 300, -- 设置 Git 操作的超时时间为 300 秒
    },
    checker = {
        enabled = false, -- 禁用自动检查插件更新
        notify = false, -- 即使有更新也不显示通知
    },
    ui = {
        border = vim.g.borderStyle,
        backdrop = 100, -- 设置背景遮罩的透明度为 100
    },
    change_detection = {
        enabled = false, -- 禁用自动检测配置文件
        notify = true, -- 检测到配置变更时显示通知
    },
}