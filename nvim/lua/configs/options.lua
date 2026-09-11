vim.g.mapleader = ' '

-- Netrw Disabling
--
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Line Numbering
--
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Indentation
--
vim.opt.tabstop = 4        -- Number of spaces a <Tab> character represents
vim.opt.shiftwidth = 4     -- Number of spaces for each indentation level
vim.opt.softtabstop = 4    -- Number of spaces inserted when pressing <Tab>
vim.opt.expandtab = true   -- Use spaces instead of <Tab> characters

vim.opt.smartindent = true -- Automatically indent new lines
vim.opt.autoindent = true  -- Copy indentation from the previous line

