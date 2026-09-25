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

local lockfile = vim.fn.stdpath("config")
  .. (vim.fn.has("nvim-0.12") == 1 and "/lazy-lock.json" or "/lazy-lock-nvim11.json")

require("lazy").setup({
	{ import = "eric.plugins" },
	{ import = "eric.plugins.lsp" },

}, { lockfile = lockfile })
