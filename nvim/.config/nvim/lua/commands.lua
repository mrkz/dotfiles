-- launch a terminal below
vim.cmd([[command! -nargs=* -bang -complete=file Terminal belowright 20%split +terminal<bang> <args>]])
