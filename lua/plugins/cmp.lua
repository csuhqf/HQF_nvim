return {
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()

			-- 1. 主配置 (插入模式保持不变)
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})

			-- === 修复重点在这里 ===
			-- 定义一个通用的命令行按键映射表
			-- 这里显式指定了在 'c' (command) 模式下，Ctrl+j/k 对应上下选择
			local cmdline_mappings = cmp.mapping.preset.cmdline({
				["<C-j>"] = { c = cmp.mapping.select_next_item() }, -- 下一个
				["<C-k>"] = { c = cmp.mapping.select_prev_item() }, -- 上一个
				["<CR>"] = { c = cmp.mapping.confirm({ select = true }) }, -- 回车确认
			})

			-- 2. 搜索模式 (/)
			cmp.setup.cmdline("/", {
				mapping = cmdline_mappings, -- 应用修复后的按键
				sources = {
					{ name = "buffer" },
				},
			})

			-- 3. 命令行模式 (:)
			cmp.setup.cmdline(":", {
				mapping = cmdline_mappings, -- 应用修复后的按键
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
}
