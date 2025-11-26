return {
    {
        -- 插件名称：TokyoNight 主题
        "folke/tokyonight.nvim",
        -- 优先级：最高 (1000)，确保启动时第一时间加载主题
        priority = 1000, 
        -- 这一步是关键：加载完插件后，立即执行 colorscheme 命令
        config = function()
            vim.cmd([[colorscheme tokyonight]])
        end,
    }
}
