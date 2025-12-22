vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.number = true
vim.o.relativenumber = true

require ("config.lazy")
require ("config.keymaps")
