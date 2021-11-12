local cmd = vim.cmd
-- close nvim if the only window left is NERDTRee
vim.cmd [[ autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif ]]
