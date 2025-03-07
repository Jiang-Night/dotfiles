return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    root_dir = function(fname)
        local util = require 'lspconfig.util'
    end,
}