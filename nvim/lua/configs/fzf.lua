-- Search FZF
--

require("fzf-lua").setup({
  fzf_opts = {
    ["--layout"] = "reverse-list",
  },
})

local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "Search Buffers" })

