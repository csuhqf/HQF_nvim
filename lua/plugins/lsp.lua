return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim", -- 保留：自动安装工具
			"hrsh7th/cmp-nvim-lsp",
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

			-- 2. 自动安装工具 (保留)
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"isort",
					"prettier", -- 格式化工具
					"clang-format", -- C/C++ 格式化工具
				},
			})

			-- 3. 准备 Capabilities
			-- 保留 snippetSupport 是为了让 CSS/HTML 的基础补全更丰富，这是无副作用的优化
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- 4. 配置 LSP
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"pyright",
					"html",
					"cssls",
					"emmet_language_server",
					"ts_ls",
					"clangd",
				},
				handlers = {
					-- A. 默认处理器
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- B. Lua 配置
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = { diagnostics = { globals = { "vim" } } },
							},
						})
					end,

					-- C. Emmet 配置 (保留常用 Web 类型)
					["emmet_language_server"] = function()
						require("lspconfig").emmet_language_server.setup({
							capabilities = capabilities,
							filetypes = {
								"html",
								"css",
								"javascript",
								"javascriptreact",
							},
						})
					end,

					-- D. JS/TS 配置 (回归标准)
					-- 不再强制它去读 HTML，只处理标准的 JS/TS/React 文件
					["ts_ls"] = function()
						require("lspconfig").ts_ls.setup({
							capabilities = capabilities,
							-- 只要是 js/ts/jsx/tsx 它都会工作
						})
					end,

					-- E. C/C++ 配置
					["clangd"] = function()
						require("lspconfig").clangd.setup({
							-- 传递之前定义的 capabilities
							capabilities = capabilities,
							-- 关键：配置 clangd 的启动参数
							cmd = {
								"clangd",
								"--background-index",
								"--header-insertion=never",
								"--completion-style=detailed", -- 更好的补全信息
								"-j=4",
							},
							-- 确保它只对 C/C++ 文件类型工作
							filetypes = { "c", "cpp", "cc", "cxx", "h", "hpp" },
						})
					end,
				},
			})

			-- 5. 全局快捷键
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
				end,
			})
		end,
	},
}
