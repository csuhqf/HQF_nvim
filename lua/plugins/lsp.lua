return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- =========================================================

			-- 1. 初始化 Mason
			require("mason").setup({
				ui = { icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" } },
			})

			-- 2. 负责下载工具 (必须保留 rust-analyzer，确保硬盘上有这个文件)
			require("mason-tool-installer").setup({
				ensure_installed = {
					"black",
					"isort",
					"prettier",
					"codelldb",
					"rust-analyzer", -- 下载它，但别配置它
				},
			})

			-- 3. 准备 Capabilities (补全能力)
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			capabilities.textDocument.completion.completionItem.snippetSupport = true

			-- 4. 配置 LSP (通用语言)
			require("mason-lspconfig").setup({
				-- 确保名单里没有 rust_analyzer
				ensure_installed = {
					"lua_ls",
					"pyright",
					"html",
					"cssls",
					"emmet_language_server",
					"ts_ls",
				},

				-- 使用 handlers 自动配置其他语言
				handlers = {
					-- 默认处理器 (所有在 ensure_installed 里的语言都会走这里)
					function(server_name)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,

					-- Lua 特殊配置
					["lua_ls"] = function()
						require("lspconfig").lua_ls.setup({
							capabilities = capabilities,
							settings = { Lua = { diagnostics = { globals = { "vim" } } } },
						})
					end,

					-- Emmet 特殊配置
					["emmet_language_server"] = function()
						require("lspconfig").emmet_language_server.setup({
							capabilities = capabilities,
							filetypes = { "html", "css", "javascript", "javascriptreact" },
						})
					end,

					-- TS 特殊配置
					["ts_ls"] = function()
						require("lspconfig").ts_ls.setup({ capabilities = capabilities })
					end,
				},
			})

			-- 5. 全局快捷键 (gd, K, <Leader>rn 等)
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
