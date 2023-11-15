-- custom mappings
-- see pickers https://github.com/nvim-telescope/telescope.nvim#pickers
--
-- list/find files in current working directory (respecting .gitignore)
vim.api.nvim_set_keymap('n', '<Leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], { noremap = true, silent = true })
-- live grep in current working directory (respecting .gitignore)
vim.api.nvim_set_keymap('n', '<Leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], { noremap = true, silent = true })
-- live grep in current buffer
vim.api.nvim_set_keymap('n', '<Leader>g', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>]], { noremap = true, silent = true })
-- handy man pages
vim.api.nvim_set_keymap('n', '<Leader>m', [[<cmd>lua require('telescope.builtin').man_pages()<cr>]], { noremap = true, silent = true })
-- list current nvim mappings
vim.api.nvim_set_keymap('n', '<Leader>?', [[<cmd>lua require('telescope.builtin').keymaps()<cr>]], { noremap = true, silent = true })

-- configurations
local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- clone default telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- search in hidden dot files
table.insert(vimgrep_arguments, "--hidden")
-- but skip .git directory
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

telescope.setup{
    defaults = {
        layout_strategy = 'vertical',
        layout_config = { width = 0.95, height = 0.95 },
        file_ignore_patterns = { "^vendor/" },
        vimgrep_arguments = vimgrep_arguments,
    },
    pickers = {
        find_files = {
            find_command = {"rg", "--files", "--hidden", "--glob", "!.git/*" },
        }
    }
}
