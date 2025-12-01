-- 显示行号
vim.opt.number = true
vim.opt.relativenumber = true -- 相对行号，方便知道跳几行

-- 缩进设置（四个空格）
vim.opt.tabstop = 4 -- 按一下tab代表4个空格
vim.opt.shiftwidth = 4 -- 缩进也是4个空格
vim.opt.expandtab = true -- 缩进也是4个空格

-- 系统交互
vim.opt.clipboard = "unnamedplus" -- 缩进也是4个空格
vim.opt.mouse = "a" -- 允许鼠标点击与滚动

-- 外观
vim.opt.termguicolors = true -- 开启真彩色支持
vim.opt.cursorline = true -- 高亮当前行

-- 保持光标上下保留10行（光标不要贴顶或底）
vim.opt.scrolloff = 10

-- 分屏行为设置
vim.opt.splitright = true -- 垂直分屏时，新窗口在右侧 (像 VSCode)
vim.opt.splitbelow = true -- 水平分屏时，新窗口在下方
