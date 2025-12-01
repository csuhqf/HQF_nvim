return {
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- 依赖图标
		version = "*",
		event = "VeryLazy", -- 延迟加载，不拖慢启动速度
		config = function()
			require("bufferline").setup({
				options = {
					-- 风格设置
					mode = "buffers", -- 显示 Buffer (文件)
					style_preset = require("bufferline").style_preset.default,
					separator_style = "slant", -- 像 VSCode 那样的斜角标签
					always_show_bufferline = true,

					-- 集成诊断信息 (比如文件有错，标签页上会显示红点)
					diagnostics = "nvim_lsp",

					-- 让左侧的文件树 (Neo-tree) 不被标签栏遮挡
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							highlight = "Directory",
							text_align = "left",
						},
					},
				},
			})

			-- === 快捷键设置 (最顺手的方案) ===

			-- 1. 左右切换标签：使用 Shift + h / l
			-- 这比去按 gt 或 gT 快多了，手不用离开主键盘区
			vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Prev Buffer" })
			vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })

			-- 2. 关闭当前标签：使用 Space + x
			-- (原生是 :bd，但映射一下更方便)
			-- vim.keymap.set("n", "<Leader>x", ":bdelete<CR>", { desc = "Close Buffer" })
			-- 修改后的代码：使用 mini.bufremove 智能关闭
			vim.keymap.set("n", "<Leader>x", function()
				require("mini.bufremove").delete(0, false)
			end, { desc = "Close Buffer" })

			-- 3. 移动标签位置 (整理强迫症专用)
			-- Shift + < 或 > 来左右移动标签
			vim.keymap.set("n", "<S-Left>", ":BufferLineMovePrev<CR>", { desc = "Move Buffer Left" })
			vim.keymap.set("n", "<S-Right>", ":BufferLineMoveNext<CR>", { desc = "Move Buffer Right" })
		end,
	},
}
