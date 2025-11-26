-- lua/config/lazy.lua

-- 1. 准备 Lazy.nvim 的安装路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- 2. 如果没安装，就自动从 GitHub 克隆下来
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 使用稳定版
    lazypath,
  })
end

-- 3. 将其加入 Neovim 的运行路径
vim.opt.rtp:prepend(lazypath)

-- 4. 启动并加载 "lua/plugins" 文件夹下的所有插件
require("lazy").setup("plugins", {
    -- 这里可以放一些 Lazy 本身的配置
    ui = {
        border = "rounded", -- 弹窗圆角边框
    },
    change_detection = {
        notify = false, -- 关闭每次修改配置时的自动弹窗提示（太吵了）
    },
})
