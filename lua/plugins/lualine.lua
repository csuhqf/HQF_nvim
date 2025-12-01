return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					theme = "auto", -- 自动跟随你的 TokyoNight 主题
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},
}
