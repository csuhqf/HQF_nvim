return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			-- === 1. 自定义颜色主题 (基于 Tokyonight) ===
			local colors = {
				blue = "#7aa2f7",
				cyan = "#7dcfff",
				black = "#15161e",
				white = "#c0caf5",
				red = "#f7768e",
				violet = "#bb9af7",
				grey = "#24283b",
			}

			local bubbles_theme = {
				normal = {
					a = { fg = colors.black, bg = colors.blue },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white }, -- 透明背景
				},

				insert = { a = { fg = colors.black, bg = colors.cyan } },
				visual = { a = { fg = colors.black, bg = colors.violet } },
				replace = { a = { fg = colors.black, bg = colors.red } },

				inactive = {
					a = { fg = colors.white, bg = colors.black },
					b = { fg = colors.white, bg = colors.black },
					c = { fg = colors.white },
				},
			}

			-- === 2. 科研专用组件：显示 Python 环境 ===
			local function python_env()
				local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
				if venv then
					-- 如果是路径，只取最后一段文件名
					local name = vim.fn.fnamemodify(venv, ":t")
					return "🐍 " .. name
				end
				return ""
			end

			-- === 3. 核心配置 ===
			require("lualine").setup({
				options = {
					theme = bubbles_theme,
					-- 【关键】使用圆角分隔符，制造气泡感
					component_separators = "",
					section_separators = { left = "", right = "" },
					disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },

					-- 【关键】全局状态栏：无论开多少分屏，底部只有一条长栏
					globalstatus = true,
				},
				sections = {
					-- 左侧气泡
					lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
					lualine_b = {
						"filename",
						"branch",
						{
							"diff",
							symbols = { added = "➕ ", modified = "📝 ", removed = "❌ " },
						},
					},
					lualine_c = {
						-- 中间显示 LSP 诊断信息
						{
							"diagnostics",
							sources = { "nvim_diagnostic" },
							symbols = { error = " ", warn = " ", info = " ", hint = " " },
						},
					},

					-- 右侧气泡
					lualine_x = {
						python_env, -- 显示 Conda 环境
						"filetype",
					},
					lualine_y = { "fileformat", "encoding" },
					lualine_z = {
						{ "progress", separator = { right = "" }, left_padding = 2 },
					},
				},
				extensions = { "neo-tree", "lazy" },
			})
		end,
	},
}
