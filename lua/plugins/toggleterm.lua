return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			-- 1. 基础配置
			require("toggleterm").setup({
				-- 定义终端大小
				size = function(term)
					if term.direction == "horizontal" then
						return 15 -- 【设置】水平分屏时，高度为 15 行
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<C-\>]],
				start_in_insert = true,
				insert_mappings = true,
				persist_size = true,
				close_on_exit = true,
				shell = vim.o.shell,
			})

			-- === 2. 定义专门的终端实例 ===
			local Terminal = require("toggleterm.terminal").Terminal

			-- 定义 IPython (改为水平方向)
			local ipython = Terminal:new({
				cmd = "ipython",
				hidden = true,
				direction = "horizontal", -- 【修改点 1】改为 horizontal (底部)
				on_open = function(term)
					vim.cmd("startinsert!")
					-- 自动关闭 IPython 缩进，防止粘贴报错
					vim.api.nvim_chan_send(term.job_id, "%config TerminalInteractiveShell.autoindent = False\n")
					vim.api.nvim_chan_send(term.job_id, "clear\n")
				end,
			})

			-- === 3. 辅助函数 ===

			function _G.get_visual_selection()
				vim.cmd('noau normal! "vy"')
				local text = vim.fn.getreg("v")
				vim.fn.setreg("v", {})
				text = string.gsub(text, "\n", "\r")
				return text
			end

			-- 智能开关 (Space + t)
			function _G._smart_toggle()
				local ft = vim.bo.filetype
				if ft == "python" then
					ipython:toggle()
				else
					-- 【修改点 2】非 Python 文件也默认在底部打开
					require("toggleterm").toggle(nil, nil, vim.o.shell, "horizontal")
				end
			end

			-- 智能发送选中代码
			function _G._smart_send_visual()
				local ft = vim.bo.filetype
				if ft == "python" then
					if not ipython:is_open() then
						ipython:open()
					end
					local text = _G.get_visual_selection()
					ipython:send(text)
				else
					require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
				end
			end

			-- 智能发送当前行
			function _G._smart_send_line()
				local ft = vim.bo.filetype
				if ft == "python" then
					if not ipython:is_open() then
						ipython:open()
					end
					local content = vim.api.nvim_get_current_line()
					ipython:send(content .. "\r")
					vim.cmd("normal! j")
				else
					require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
				end
			end

			-- E. 智能查看变量 (全能版)
			-- 自动识别: 矩阵(看Shape) / 列表(看Length) / 数值(看Value)
			function _G._smart_inspect_variable()
				local ft = vim.bo.filetype
				if ft == "python" then
					if not ipython:is_open() then
						ipython:open()
					end

					-- 获取光标下的单词 (变量名)
					local var = vim.fn.expand("<cword>")

					-- === 核心魔法 ===
					-- 构建一段 Python 代码，利用 hasattr 进行类型嗅探
					-- 逻辑：
					-- 1. 如果有 .shape (是矩阵/DataFrame): 看形状、类型、极值
					-- 2. 如果有 .__len__ (是列表/字典): 看长度、预览内容
					-- 3. 其他情况 (数字/字符): 直接看值
					local command = string.format(
						"print(f'\\n🔍 INSPECT: %s <{type(%s).__name__}>'); "
							.. "print(f'   Shape: {%s.shape}\\n   Dtype: {%s.dtype}\\n   Range: [{%s.min()}, {%s.max()}]') if hasattr(%s, 'shape') else "
							.. "print(f'   Length: {len(%s)}\\n   Content: {str(%s)[:200]}...') if hasattr(%s, '__len__') and not isinstance(%s, (str, int, float)) else "
							.. "print(f'   Value: {%s}')",
						var,
						var, -- 标题
						var,
						var,
						var,
						var,
						var, -- 情况1: 矩阵
						var,
						var,
						var,
						var, -- 情况2: 列表/字典
						var -- 情况3: 普通数值
					)

					-- 发送给 IPython
					ipython:send(command .. "\r")
				else
					print("只支持 Python 文件")
				end
			end

			-- === 4. 快捷键 ===
			vim.keymap.set("n", "<Leader>t", "<cmd>lua _smart_toggle()<CR>", { noremap = true, silent = true })
			vim.keymap.set("v", "<Leader>s", "<cmd>lua _smart_send_visual()<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<Leader>s", "<cmd>lua _smart_send_line()<CR>", { noremap = true, silent = true })
			vim.keymap.set(
				"n",
				"<Leader>i",
				"<cmd>lua _smart_inspect_variable()<CR>",
				{ noremap = true, silent = true }
			)

			-- 终端防卡死键位
			function _G.set_terminal_keymaps()
				local opts = { buffer = 0 }
				vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
				vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts) -- 向下切出终端
				vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts) -- 向上切回代码
				vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
			end
			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
}
