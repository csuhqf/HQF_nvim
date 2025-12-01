return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main", -- 必须用 canary 分支才能用最新功能
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- 依赖你刚才装的补全插件
			{ "nvim-lua/plenary.nvim" },
		},
		build = "make tiktoken", -- 编译加速模块 (macOS 自带环境，通常没问题)
		opts = {
			debug = false,

			-- 1. 指定使用最聪明的便宜快速模型
			model = "GPT-5 mini",

			-- 2. 窗口样式设置
			window = {
				layout = "vertical", -- 垂直分屏 (在右侧)
				width = 0.3, -- 宽度占 30%
				border = "rounded", -- 圆角边框
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			local select = require("CopilotChat.select")

			chat.setup(opts)

			-- === 快捷键设置 (InSAR 科研专用) === --

			-- 1. 打开/关闭聊天窗口: Space + cc
			vim.keymap.set("n", "<Leader>cc", function()
				chat.toggle()
			end, { desc = "Toggle Copilot Chat" })

			-- 2. 解释代码: Space + ce (Explain)
			-- 选中一段看不懂的算法，按这个键
			vim.keymap.set("v", "<Leader>ce", function()
				chat.ask("请解释这段代码的逻辑", { selection = select.visual })
			end, { desc = "Explain Code" })

			-- 3. 修复 Bug: Space + cf (Fix)
			-- 代码报错了？选中它，按这个键
			vim.keymap.set("v", "<Leader>cf", function()
				chat.ask("这段代码有 bug，请帮我修复", { selection = select.visual })
			end, { desc = "Fix Code" })

			-- 4. 原地修改 (黑科技): Space + ci (In-place)
			-- 选中代码 -> 输入指令 -> 直接在文件里改掉，不弹窗
			vim.keymap.set({ "n", "v" }, "<Leader>ci", function()
				local input = vim.fn.input("Agent 指令 (比如: 优化这段循环): ")
				if input ~= "" then
					chat.ask(input, {
						selection = select.visual,
						window = {
							layout = "replace", -- 直接替换原代码
						},
					})
				end
			end, { desc = "Agent In-Place Edit" })
			-- 5. 切换模型: Space + cm (Chat Model)
			vim.keymap.set("n", "<Leader>cm", function()
				require("CopilotChat").select_model()
			end, { desc = "Select Copilot Model" })
		end,
	},
}
