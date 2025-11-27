return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter", -- 进入插入模式时才加载，启动更快
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- 核心：让 cmp 从 LSP 获取补全
            "hrsh7th/cmp-buffer",   -- 从当前文件内容获取补全
            "hrsh7th/cmp-path",     -- 文件路径补全
            "L3MON4D3/LuaSnip",     -- 代码片段引擎 (必须有，否则 cmp 会报错)
            "saadparwaiz1/cmp_luasnip", -- 桥接 cmp 和 LuaSnip
            "rafamadriz/friendly-snippets", -- 提供大量现成的代码片段
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            -- 加载 VSCode 风格的代码片段
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                -- 必须指定代码片段引擎
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- 快捷键设置 (这一步很关键)
                mapping = cmp.mapping.preset.insert({
                    ['<C-k>'] = cmp.mapping.select_prev_item(), -- 上一个建议
                    ['<C-j>'] = cmp.mapping.select_next_item(), -- 下一个建议
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),    -- 向上滚动文档
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),     -- 向下滚动文档
                    ['<C-Space>'] = cmp.mapping.complete(),     -- 手动触发补全
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- 回车确认选择
                }),
                -- 补全源的优先级
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- 优先显示 LSP 的结果 (比如变量、函数)
                    { name = "luasnip" },  -- 其次是代码片段
                }, {
                    { name = "buffer" },   -- 最后是当前文本里的单词
                    { name = "path" },     -- 或者是文件路径
                }),
            })
        end,
    }
}
