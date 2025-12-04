return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- 文件图标
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				window = {
					width = 30, -- 侧边栏宽度
					mappings = {
						["/"] = "noop", -- 禁用默认的搜索功能
						-- 【核心修改】将 'f' 键绑定给 Telescope
						["f"] = function(state)
							local node = state.tree:get_node()
							local path = state.path -- 获取当前 Neo-tree 的根目录

							-- 调用 Telescope 搜索，搜完回车直接开，不用按 Tab
							require("telescope.builtin").find_files({
								cwd = path,
								prompt_title = "🔍 Search in: " .. vim.fn.fnamemodify(path, ":t"),
							})
						end,
					},
				},
				filesystem = {
					filtered_items = {
						visible = true, -- 显示隐藏文件 (.gitignore 等)
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_file = {
						enabled = true, -- 切换文件时，侧边栏自动定位到该文件
					},
				},
			})

			-- 设置快捷键：空格 + e (Explorer) 来打开/关闭侧边栏
			vim.keymap.set("n", "<Leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })
		end,
	},
}
