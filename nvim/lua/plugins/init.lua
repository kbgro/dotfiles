-- Plugins
--

-- File Explorer
--
vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

-- Setup config
--
require("configs.nvim-tree")
