return {
    {
        "folke/lazydev.nvim",
        ft = "lua", -- 仅在 lua 文件中启用
        opts = {
            library = {
                -- 为 Lazy.nvim 的配置提供补全
                { path = "luvit-meta/library", words = { "vim%.uv" } },
            },
        },
    },
    -- 这是一个可选的辅助插件，提供类型定义，让补全更精准
    { "Bilal2453/luvit-meta", lazy = true },
}
