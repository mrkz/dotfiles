local set = vim.o
local cmd = vim.cmd
local nvim_cmd = vim.api.nvim_command
-- global options
set.termguicolors = true
set.cursorline = true
set.number = true
set.relativenumber = true
set.colorcolumn="80"
-- theme
local ok, theme  = pcall(require, 'monokai')
if ok then
    theme.setup{palette = theme.soda}
end
-- show trailing whitespaces in ugly red
cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
cmd([[ match ExtraWhitespace /\s\+$/ ]])
-- Transparent background for termguicolors
cmd([[ highlight Normal guibg=none ]])
cmd([[ highlight NonText guibg=none ]])
-- syntax enable
cmd([[syntax enable]])
-- indent on
cmd([[filetype plugin indent on]])
-- unset relative number on insert mode
-- but use both number and relative number on normal mode
-- so it's easier to move around
-- inspired from https://jeffkreeftmeijer.com/vim-number/
nvim_cmd('augroup numberToggle')
nvim_cmd('autocmd!')
nvim_cmd('autocmd BufEnter,FocusGained,InsertLeave * set relativenumber')
nvim_cmd('autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber')
nvim_cmd('augroup END')
