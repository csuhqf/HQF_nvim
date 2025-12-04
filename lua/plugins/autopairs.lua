return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- 进入插入模式时才加载，不拖慢启动速度
		dependencies = { "hrsh7th/nvim-cmp" }, -- 依赖 cmp，为了实现更高级的配合
		config = function()
			-- 1. 基础配置
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true, -- 开启 Treesitter 检查 (防止在注释/字符串里乱补全)
				ts_config = {
					lua = { "string" }, -- 在 lua 的字符串里不补全
					python = { "string" }, -- 如果你想让 python 字符串里也不补全，可以打开这行
				},
				-- 这里的 map_c_h 是指 Ctrl+h 是否用来删除括号对，默认 true 即可
			})

			-- 2. 与 nvim-cmp 的亲密配合 (关键步骤)
			-- 效果：当你在补全菜单里选中一个函数按回车时，它自动补上 ()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			-- 监听 cmp 的确认事件
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
