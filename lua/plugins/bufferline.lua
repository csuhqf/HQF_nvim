return {
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"echasnovski/mini.bufremove",
		},
		version = "*",
		event = "VeryLazy",
		config = function()
			-- === 1. 强力监控逻辑 ===
			-- 创建一个自动命令组，防止重复
			local group = vim.api.nvim_create_augroup("DashboardTabline", { clear = true })

			-- 监听 "BufEnter" (进入缓冲区) 事件
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				group = group,
				callback = function()
					-- 获取当前文件类型
					local ft = vim.bo.filetype

					-- 如果是 Dashboard，或者 Alpha (另一个启动页插件)，甚至是空的
					if ft == "dashboard" or ft == "alpha" then
						vim.opt.showtabline = 0 -- 隐藏
					else
						-- 只有当真的有 buffer 需要显示时才开启
						-- 避免刚启动那一瞬间的闪烁
						if #vim.fn.getbufinfo({ buflisted = 1 }) > 0 then
							vim.opt.showtabline = 2 -- 显示
						end
					end
				end,
			})

			-- === 2. Bufferline 常规配置 ===
			require("bufferline").setup({
				options = {
					mode = "buffers",
					style_preset = require("bufferline").style_preset.no_italic,
					separator_style = "slant",
					always_show_bufferline = true,
					diagnostics = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return " " .. icon .. count
					end,
					offsets = {
						{
							filetype = "neo-tree",
							text = "QFVIM Explorer",
							highlight = "Directory",
							text_align = "left",
							separator = true,
						},
					},
					close_command = function(n)
						require("mini.bufremove").delete(n, false)
					end,
					right_mouse_command = function(n)
						require("mini.bufremove").delete(n, false)
					end,
				},
			})

			-- === 3. 快捷键 ===
			vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
			vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer" })
			vim.keymap.set("n", "<Leader>x", function()
				require("mini.bufremove").delete(0, false)
			end, { desc = "Close Buffer" })
			vim.keymap.set("n", "<S-Left>", "<cmd>BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })
			vim.keymap.set("n", "<S-Right>", "<cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })
			vim.keymap.set("n", "<Leader>bp", "<cmd>BufferLineTogglePin<CR>", { desc = "Toggle Pin" })
		end,
	},
}
