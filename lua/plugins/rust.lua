return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = false,
		config = function()
			vim.g.rustaceanvim = {
				-- LSP 配置
				server = {
					on_attach = function(client, bufnr)
						-- === 1. 核心修复：开启 Code Lens (灰色虚拟文本) ===
						if client.supports_method("textDocument/codeLens") then
							local group = vim.api.nvim_create_augroup("RustCodeLens", { clear = true })

							-- 当光标移动后停顿、插入模式结束、或切换 buffer 时，刷新虚拟文本
							vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
								buffer = bufnr,
								group = group,
								callback = function()
									vim.lsp.codelens.refresh()
								end,
							})
						end

						-- === 2. 快捷键：触发 Code Lens ===
						-- 看到 "Run Test" 后，按 <Leader>cl 即可运行
						vim.keymap.set("n", "<Leader>cl", function()
							vim.lsp.codelens.run()
						end, { desc = "Run Code Lens", buffer = bufnr })
					end,

					default_settings = {
						["rust-analyzer"] = {
							cargo = { allFeatures = true },
							checkOnSave = true,
							check = {
								command = "clippy",
							},
							-- 确保 rust-analyzer 本身开启了这个功能
							lens = {
								enable = true,
							},
							inlayHints = {
								bindingModeHints = { enable = false },
								chainingHints = { enable = true },
								closingBraceHints = { enable = true, minLines = 25 },
								closureReturnTypeHints = { enable = "always" },
								lifetimeElisionHints = { enable = "always", useParameterNames = true },
								maxLength = 25,
								parameterHints = { enable = true },
								reborrowHints = { enable = "always" },
								renderColons = true,
								typeHints = {
									enable = true,
									hideClosureInitialization = false,
									hideNamedConstructor = false,
								},
							},
						},
					},
				},
			}

			-- 补充：Rust Runnables 快捷键 (之前提到的方案二)
			vim.keymap.set("n", "<Leader>r", function()
				vim.cmd.RustLsp("runnables")
			end, { desc = "Rust Runnables" })
		end,
	},

	-- Crates 管理
	{
		"saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml" },
		opts = {},
	},
}
