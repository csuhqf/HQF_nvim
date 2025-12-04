return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			-- 你可以在这里配置标签颜色、跳转引擎等
			-- 默认配置已经非常完美，通常留空即可
			modes = {
				search = {
					enabled = false, -- 如果你不想让 flash 接管 / 搜索，就设为 false
				},
			},
		},
		keys = {
			-- 1. 核心功能：按 s 开启闪现跳转
			-- 按下 s -> 输入你想去的地方的前两个字母 -> 屏幕上出现标签 -> 按标签字母直接飞过去
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},

			-- 2. 高级功能：按 S 选中代码块 (基于 Treesitter)
			-- 按下 S -> 每次按键都会自动选中更大的语法块 (比如选中整个函数、整个循环)
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},

			-- 3. 远程操作 (Remote Flash): 按 r (仅在操作符模式下有效)
			-- 比如你想删除远处的某一行：按 d -> r -> 跳转到那一行 -> 完成删除
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
		},
	},
}
