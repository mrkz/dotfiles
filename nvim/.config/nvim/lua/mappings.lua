-- make mapping less cumbersome
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- actual mappings

-- nerdtree
map('n', '<F8>', [[<cmd>:NERDTreeToggle<CR>]], nil)

-- tagbar
map('n', '<F9>', [[<cmd>:TagbarToggle<CR>]], nil)
