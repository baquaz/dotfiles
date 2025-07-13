-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- Move lines up/down
keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line up" })
keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line down" })
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Open Diagnostics in Float" })

-- Oil
keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

-- Format Current File
keymap.set("n", "<leader>kf", function()
  require("conform").format({
    timeout_ms = 500,
    lsp_format = "fallback",
  })
end, { desc = "Format current file" })

-- Exit
keymap.set("n", "<leader>qq", "<cmd>:qa<CR>", { desc = "Quit all nvim" })
keymap.set("n", "<leader>qf", "<cmd>:qa!<CR>", { desc = "Quit Force all nvim" })
