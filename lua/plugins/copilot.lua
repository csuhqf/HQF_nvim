return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter", -- 进入插入模式时才加载
		config = function()
			require("copilot").setup({
				-- 核心设置：幽灵文字 (Ghost Text)
				suggestion = {
					enabled = true,
					auto_trigger = true, -- 自动显示建议
					debounce = 75, -- 延迟 75ms，防止卡顿
					keymap = {
						accept = "<M-l>", -- 按 Alt + l 接受建议 (避免和 Tab 冲突)
						accept_word = false,
						accept_line = false,
						next = "<M-]>", -- 下一条建议
						prev = "<M-[>", -- 上一条建议
						dismiss = "<C-]>", -- 关闭建议
					},
				},
				-- 面板设置 (偶尔用来查看多个建议)
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>",
					},
					layout = {
						position = "bottom", -- 面板显示在下方
						ratio = 0.4,
					},
				},
				-- 优化：关闭非必要的 filetypes
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
			})
		end,
	},
}
