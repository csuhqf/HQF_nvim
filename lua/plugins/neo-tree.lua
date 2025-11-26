return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- 文件图标
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup({
                window = {
                    width = 30, -- 侧边栏宽度
                },
                filesystem = {
                    filtered_items = {
                        visible = true, -- 显示隐藏文件 (.gitignore 等)
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                    follow_current_file = {
                        enabled = true, -- 切换文件时，侧边栏自动定位到该文件
                    },
                },
            })

            -- 设置快捷键：空格 + e (Explorer) 来打开/关闭侧边栏
            vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
        end,
    }
}
