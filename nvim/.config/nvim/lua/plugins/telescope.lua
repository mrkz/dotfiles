-- custom mappings
vim.api.nvim_set_keymap('n', '<Leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fm', [[<cmd>lua require('telescope.builtin').man_pages()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gb', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>?', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]], { noremap = true, silent = true })

-- configurations
require('telescope').setup{
    defaults = {
        layout_strategy = 'vertical',
        layout_config = { width = 0.95, height = 0.95 },
        file_ignore_patterns = { "^vendor/" }
    },
}
