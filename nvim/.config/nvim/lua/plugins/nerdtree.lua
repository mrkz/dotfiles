local nvim_cmd = vim.api.nvim_command
-- leave vim if nerdtree is the only open buffer left
nvim_cmd('autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif')
