-- 1. 设置主键 (Leader Key)
-- 这就是 Neovim 的"扳机"，后续所有插件操作都会用它开头。
-- 这里设置为 "空格键"，因为它是键盘上最大的键，最容易按。
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 2. 模式切换：jk 大法
-- 在插入模式下，快速按 jk 两个键，直接退出到普通模式
-- 彻底解放你的小拇指，不用再去够左上角的 Esc
keymap("i", "jk", "<Esc>", opts)

-- 3. 快速保存与退出
-- 按 "空格 + w" 保存
keymap("n", "<Leader>w", ":w<CR>", opts)
-- 按 "空格 + q" 退出
keymap("n", "<Leader>q", ":q<CR>", opts)

-- 4. 窗口移动
-- 以后开了分屏，不用按 Ctrl+w+h/j/k/l 了，直接 Ctrl+h/j/k/l
keymap("n", "<C-h>", "<C-w>h", opts) -- 光标去左边窗口
keymap("n", "<C-j>", "<C-w>j", opts) -- 光标去下边窗口
keymap("n", "<C-k>", "<C-w>k", opts) -- 光标去上边窗口
keymap("n", "<C-l>", "<C-w>l", opts) -- 光标去右边窗口

-- 5. 取消搜索高亮
-- 搜索完之后那些高亮很烦人，按 "空格 + nh" (no highlight) 清除
keymap("n", "<Leader>nh", ":nohl<CR>", opts)

-- 6. 分屏快捷键
keymap("n", "<Leader>sv", "<C-w>v", opts) -- Space + sv (Split Vertical) 左右分屏
keymap("n", "<Leader>sh", "<C-w>s", opts) -- Space + sh (Split Horizontal) 上下分屏
