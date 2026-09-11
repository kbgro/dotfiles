-- options
--

-- Globals
--
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.have_nerd_font = true

-- Netrw Disabling
--
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Numbering
--
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'n'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Indentation
--
vim.opt.tabstop = 4        -- Number of spaces a <Tab> character represents
vim.opt.shiftwidth = 4     -- Number of spaces for each indentation level
vim.opt.softtabstop = 4    -- Number of spaces inserted when pressing <Tab>
vim.opt.expandtab = true   -- Use spaces instead of <Tab> characters
vim.opt.smartindent = true -- Automatically indent new lines
vim.opt.autoindent = true  -- Copy indentation from the previous line
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

-- Fold
--
vim.opt.foldlevel = 99
vim.opt.foldtext = ''

-- Formatting & autocomplete
--
vim.opt.formatoptions = 'jcroqlnt' -- tcqj
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --vimgrep'
vim.opt.inccommand = 'nosplit' -- preview incremental substitute
vim.opt.jumpoptions = 'view'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.smoothscroll = true

-- Diagnostic
--
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',       -- or '■', '→'
    spacing = 2,
  },
  signs = true,          -- show signs in gutter
  underline = true,      -- underline problem text
  update_in_insert = false,
})
