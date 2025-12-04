return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			-- 1. 初始化 Mason
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			-- 2.1 自动安装 LSP 服务器
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"isort",
					"prettier",
				},
			})

			-- 2.2 配置 Mason-LSPConfig (关键修改点)
			-- 我们不再手动调用 lspconfig.pyright.setup，而是使用 "handlers"
			-- 这样 Mason 会自动用正确的方式去启动 LSP，避免新版本的报错
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"html",
					"cssls",
					"emmet_language_server", -- 输入 div 等标签时自动补全
					"ts_ls",
				},

				-- 这里的 handlers 是自动处理所有 LSP 的设置
				handlers = {
					-- 默认处理程序：对于所有列表里的 LSP，直接启动
					function(server_name)
						require("lspconfig")[server_name].setup({})
					end,

					-- 特殊处理程序：针对 lua_ls 需要特殊配置
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({})
					end,
				},
			})

			-- 3. 全局快捷键 (保持不变)
			-- 当检测到 LSP 启动后，自动加载这些快捷键
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					-- gd: 跳转定义
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					-- K: 查看文档
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					-- <Space>rn: 重命名
					vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
					-- <Space>ca: 代码行为 (Code Action, 比如自动修复 imports)
					vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
}
