vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>wh", "<C-w>v", { desc = "Split window horizontally" }) -- split window vertically
keymap.set("n", "<leader>wv", "<C-w>s", { desc = "Split window vertically" }) -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>t]", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>t[", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

keymap.set("n", "<leader>zz", "<cmd>:ZenMode<CR>", { desc = "Zen Mode toggle" })
keymap.set("n", "<leader>qq", "<cmd>:qa<CR>", { desc = "Quit all nvim" })
keymap.set("n", "<leader>qf", "<cmd>:qa!<CR>", { desc = "Quit Force all nvim" })

keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line up" })
keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line down" })
keymap.set("i", "<C-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line up" })
keymap.set("i", "<C-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line down"})
keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move line down"})
