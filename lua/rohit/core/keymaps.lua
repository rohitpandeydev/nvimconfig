-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- autocomplete and Copilot
keymap.set("n", "<leader>ta", "<cmd>lua _G.toggle_completion()<CR>", { desc = "Toggle autocomplete" })
keymap.set("n", "<leader>tc", "<cmd>lua _G.toggle_copilot()<CR>", { desc = "Toggle Copilot" })
keymap.set("n", "<leader>cp", "<cmd>Copilot panel<CR>", { desc = "Open Copilot panel" })

-- Copilot suggestion keymaps
keymap.set("i", "<M-l>", "<Plug>(copilot-accept-suggestion)", { desc = "Accept Copilot suggestion" })
keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Dismiss Copilot suggestion" })

-- ChatGPT / OpenAI
keymap.set("n", "<leader>aa", "<cmd>ChatGPT<CR>", { desc = "Open ChatGPT" })
keymap.set("v", "<leader>aa", "<cmd>ChatGPT<CR>", { desc = "Open ChatGPT with selection" })
keymap.set("n", "<leader>ab", "<cmd>ChatGPTActAs<CR>", { desc = "Pick ChatGPT role" })
