-- File Explorer
--

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

require("nvim-tree").setup({
  view = {
    width = 50,
    side = "right",
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        default = '󰈚',
        folder = {
          default = '',
          empty = '',
          empty_open = '',
          open = '',
          symlink = '',
        },
        git = { unmerged = '' },
      },
    },
  },
})

