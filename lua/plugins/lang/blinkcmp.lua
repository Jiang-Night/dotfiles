-- 代码补全
return {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
    },
    -- build = 'cargo build --release',
    version = '*',
    opts = require 'custom.Lang.blink'
}