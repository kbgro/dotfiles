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

-- FZF
--

vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
})

require("configs.fzf")

-- LSP
--

vim.pack.add({
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason-lspconfig.nvim",
})

require("configs.lsp")

-- Completion
--

vim.pack.add({
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/rafamadriz/friendly-snippets",
})

require("configs.cmp")

-- Comments
--

vim.pack.add({
  "https://github.com/numToStr/Comment.nvim",
})

require("configs.comment")
