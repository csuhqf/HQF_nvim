return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',      -- 锁定版本，防止更新挂掉
        dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
        config = function()
            local builtin = require('telescope.builtin')

            -- 设置快捷键
            -- 1. 找文件 (Find Files)：按 空格+ff
            -- 最常用的功能，类似 VSCode 的 Cmd+P
            vim.keymap.set('n', '<Leader>ff', builtin.find_files, {})

            -- 2. 全局搜索文本 (Live Grep)：按 空格+fg
            -- 类似 VSCode 的 Cmd+Shift+F，搜索所有文件里的代码
            vim.keymap.set('n', '<Leader>fg', builtin.live_grep, {})

            -- 3. 找刚才打开过的文件 (Buffers)：按 空格+fb
            vim.keymap.set('n', '<Leader>fb', builtin.buffers, {})
            
            -- 4. 搜索帮助文档：按 空格+fh
            vim.keymap.set('n', '<Leader>fh', builtin.help_tags, {})
        end
    }
}
