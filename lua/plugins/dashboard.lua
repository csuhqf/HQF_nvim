return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			-- 1. 定义你的酷炫 Logo
			local logo = {
				" ██████╗ ███████╗██╗   ██╗██╗███╗   ███╗",
				"██╔═══██╗██╔════╝██║   ██║██║████╗ ████║",
				"██║   ██║█████╗  ██║   ██║██║██╔████╔██║",
				"██║▄▄ ██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
				"╚██████╔╝██║      ╚████╔╝ ██║██║ ╚═╝ ██║",
				" ╚══▀▀═╝ ╚═╝       ╚═══╝  ╚═╝╚═╝     ╚═╝",
				"",
				"     [ https://csuhqf.github.io/ ]      ",
				"",
			}

			-- 2. 编写一个函数来动态生成 Header
			-- 核心逻辑：(屏幕总高度 - Logo高度 - 菜单预估高度) / 2 = 需要填充的空行数
			local function get_header()
				local screen_height = vim.o.lines -- 获取当前窗口总行数
				local logo_height = #logo
				local menu_height = 10 -- 预估菜单+底部文字大概占10行

				-- 计算需要多少空行才能居中
				-- math.floor 向下取整
				-- max(2, ...) 保证至少留2行，防止屏幕太小变成负数报错
				local padding_lines = math.floor((screen_height - logo_height - menu_height) / 2)
				if padding_lines < 2 then
					padding_lines = 2
				end

				-- 生成最终的 header 表
				local header = {}

				-- 插入空行
				for _ = 1, padding_lines do
					table.insert(header, "")
				end

				-- 插入 Logo
				for _, line in ipairs(logo) do
					table.insert(header, line)
				end

				return header
			end

			-- 3. 启动 Dashboard
			require("dashboard").setup({
				theme = "doom",
				config = {
					--这里调用函数，每次启动时动态计算
					header = get_header(),

					center = {
						{ icon = "⚡ ", desc = "New Project         ", key = "n", action = "ene | startinsert" },
						{ icon = "🔭 ", desc = "Find File           ", key = "f", action = "Telescope find_files" },
						{ icon = "🕒 ", desc = "Recent History      ", key = "r", action = "Telescope oldfiles" },
						{ icon = "🛸 ", desc = "Live Grep           ", key = "g", action = "Telescope live_grep" },
						{
							icon = "⚙️ ",
							desc = "System Config       ",
							key = "c",
							action = "e ~/.config/nvim/init.lua",
						},
						{ icon = "📦 ", desc = "Lazy Updates        ", key = "u", action = "Lazy update" },
						{ icon = "🔥 ", desc = "Quit QFVIM          ", key = "q", action = "qa" },
					},
					footer = { " Designed by He Qifeng. " },
				},
			})
		end,
	},
}
