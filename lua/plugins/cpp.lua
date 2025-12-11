return {
	-- 1. Clangd 增强扩展 (内存布局、AST、类型提示)
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		config = function()
			require("clangd_extensions").setup({
				-- 可以在这里配置内存布局图的样式，通常用默认的即可
				inlay_hints = {
					inline = false,
				},
			})
		end,
	},

	-- 2. CMake 集成 (像 IDE 一样一键编译运行)
	{
		"Civitasv/cmake-tools.nvim",
		event = "VeryLazy",
		opts = {
			cmake_command = "cmake",
			cmake_build_directory = "build", -- 默认构建在 build 文件夹
			-- 关键：生成 compile_commands.json 给 LSP 使用
			cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },
			cmake_executor = {
				name = "quickfix", -- 编译错误直接显示在列表里
				opts = { show = "always", position = "bottom", size = 10 },
			},
			cmake_runner = {
				name = "terminal", -- 运行结果在内置终端显示
				opts = { split_direction = "horizontal", split_size = 15 },
			},
		},
		keys = {
			-- 常用快捷键
			{ "<Leader>cg", "<cmd>CMakeGenerate<CR>", desc = "CMake Generate" },
			{ "<Leader>cb", "<cmd>CMakeBuild<CR>", desc = "CMake Build" },
			{ "<Leader>cr", "<cmd>CMakeRun<CR>", desc = "CMake Run" },
			{ "<Leader>cq", "<cmd>CMakeClose<CR>", desc = "Close CMake Window" },
		},
	},
}
