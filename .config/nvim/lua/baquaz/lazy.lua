-- bootstrap lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- pass the path to the folder for all plugins, configurations...
require("lazy").setup("baquaz.plugins", {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false, -- get rid of notification anytime we create new plugin file
  },
})

