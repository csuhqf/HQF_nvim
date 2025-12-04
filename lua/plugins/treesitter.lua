return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- 安装后自动更新解析器
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				-- 确保安装这些语言的解析器
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query", --这是 Neovim 必须的
					"python",
					"markdown",
					"markdown_inline", --这是你需要用的
					"html",
					"css",
					"javascript",
				},

				-- 自动安装缺少的解析器
				auto_install = true,

				-- 启用代码高亮模块
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},

				-- 启用基于 Treesitter 的缩进 (对 Python 很有用)
				indent = {
					enable = true,
					disable = { "html" }, -- 如果你发现缩进有问题，可以在这里禁用
				},
			})
		end,
	},
}
