-- Plugins
--

-- File Explorer
--
vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
  { src = 'https://github.com/nvim-lualine/lualine.nvim' },
})

require("configs.nvim-tree")
require("configs.statusline")

-- Theming
--
vim.pack.add({
  "https://github.com/folke/tokyonight.nvim",
})

require("configs.theme")


-- Git Integration
--
vim.pack.add({
  "https://github.com/lewis6991/gitsigns.nvim",
})

require("configs.gitsigns")

-- Tree Sitter
--

vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

require("configs.tree-sitter")
