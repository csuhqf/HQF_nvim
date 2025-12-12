return {
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			-- === 果冻参数微调 ===

			-- 光标颜色：默认跟随你的光标颜色，如果看不清可以手动指定
			-- cursor_color = "#ff8800",

			-- 刚度 (Stiffness): 0.6 (默认)
			-- 数值越大，光标越"硬"，变形越小；数值越小，光标越"软"，果冻感越强
			stiffness = 0.5,

			-- 尾巴刚度 (Trailing Stiffness): 0.3 (默认)
			-- 控制拖尾消失的速度。数值越小，拖尾越长
			trailing_stiffness = 0.3,

			-- 尾巴变细的速度
			trailing_exponent = 0.2,

			-- 尾巴指数 (Trailing Exponent): 0.1 (默认)
			-- 控制拖尾变细的速度
			distance_stop_animating = 0.1,

			-- 隐藏光标的时机
			hide_target_hack = false,

			cursor_color = "#29a4bd",
		},
	},
}
