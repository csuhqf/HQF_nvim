return {
	-- 1. Clangd 增强扩展
	{
		"p00f/clangd_extensions.nvim",
		lazy = true,
		-- 【关键修复】告诉它：只要打开 c 或 cpp 文件，立刻醒来！
		ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
		config = function()
			require("clangd_extensions").setup({
				inlay_hints = {
					inline = false,
				},
				-- 可选：配置内存视图的颜色，默认即可
				memory_usage = {
					border = "none",
				},
				-- 可选：配置符号图的样式
				symbol_info = {
					border = "none",
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
