local languages = {
    'bash',
    'c',
    'c_sharp',
    'cmake',
    'cpp',
    'css',
    'dart',
    'go',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'python',
    'razor',
    'rust',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
}

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
  pattern = languages,
  callback = function()
    vim.treesitter.start()

    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
  end,
})
