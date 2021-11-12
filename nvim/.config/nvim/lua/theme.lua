local set = vim.o
local cmd = vim.cmd
-- global options
set.termguicolors = true
set.cursorline = true
set.number = true
set.relativenumber = true
set.colorcolumn="80"
-- theme
cmd([[colorscheme monokai_soda]])
-- show trailing whitespaces in ugly red
cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
cmd([[ match ExtraWhitespace /\s\+$/ ]])
-- Transparent background for termguicolors
cmd([[ highlight Normal guibg=none ]])
cmd([[ highlight NonText guibg=none ]])
