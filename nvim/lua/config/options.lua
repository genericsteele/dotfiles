-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.listchars = "trail:~,tab:>-,lead:∙,nbsp:␣"
opt.title = true
opt.relativenumber = false
opt.culopt = "number"
opt.exrc = true
opt.wrap = true
opt.breakindent = true
opt.breakindentopt = "sbr"
opt.showbreak = "↳ "
