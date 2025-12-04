return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- 打开文件时就加载
		config = function()
			require("conform").setup({
				-- 指定不同语言使用什么工具
				formatters_by_ft = {
					-- Lua 使用 stylua
					lua = { "stylua" },
					-- Python 使用 isort (排序) 和 black (格式化)
					python = { "isort", "black" },

					javascript = { "prettierd" },
					javascriptreact = { "prettierd" },
					css = { "prettierd" },
					html = { "prettierd" },
					json = { "prettierd" },
				},
				-- 开启“保存时自动格式化”
				format_on_save = {
					lsp_fallback = true, -- 如果没有专用工具，尝试用 LSP 格式化
					async = false, -- 同步执行（保存完就是格式化好的）
					timeout_ms = 1000, -- 超时设置
				},
			})
		end,
	},
}
