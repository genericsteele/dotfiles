-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<Leader>L", "<cmd>vsplit #<cr>")

local function winMove(pressedKey)
  local currentWindow = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. pressedKey)
  if currentWindow == vim.api.nvim_get_current_win() then
    if pressedKey == "j" or pressedKey == "k" then
      vim.cmd("wincmd s")
    else
      vim.cmd("wincmd v")
    end
    vim.cmd("wincmd " .. pressedKey)
  end
end

map("n", "<C-j>", function()
  winMove("j")
end)
map("n", "<C-k>", function()
  winMove("k")
end)
map("n", "<C-h>", function()
  winMove("h")
end)
map("n", "<C-l>", function()
  winMove("l")
end)
