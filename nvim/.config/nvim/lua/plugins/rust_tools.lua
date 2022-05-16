local rust_tools = require 'rust-tools'

local on_attach = function(_,bufnr)
    vim.api.nvim_buf_set_option(bufnr,'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- code actions, fix imports, minor edits needed, etc
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- diagnostics, jump to next/prev diagnostic warning/error
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
end

-- add nvim-cmp completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local opts = {
    tools = {
        -- setup inlay hints
        autoSetHints = true,
        -- configure inlay hints settings
        inlay_hints = {
            show_parameter_hints = false,
            other_hints_prefix = "",
            highlight = "comment",
        },
    },
    -- options to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.vim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = { command = "clippy" },
            }
        }
    }
}

rust_tools.setup(opts)
