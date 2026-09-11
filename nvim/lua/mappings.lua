-- Mappings
--
vim.keymap.set("v", "p", '"_dP', { desc = "Better Paste" })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear Hightlight on ESC" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape" })

-- Navigation
--
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy", silent = true })
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })


-- windows
--
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit All" })

-- buffers
--
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- source
--
vim.keymap.set("n", "<leader>rr", function()
  vim.cmd("source $MYVIMRC")
  print("Neovim config reloaded")
end, { desc = "Reload Neovim config" })
