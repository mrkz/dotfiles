local cmp = require 'cmp'

local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup {
    snippet = {
        expand = function(args)
           vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    sources = {
        { name = "buffer" },
        { name = "nvim_lsp" },
        { name = "ultisnips" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(
        function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
        ["<S-Tab>"] = cmp.mapping(
        function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
        end,
        { "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }
        ),
    }),
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = entry:get_completion_item().detail
            return vim_item
        end
    },
    experimental = {
        ghost_text = true
    },
    view = {
        entries = 'native'
    },
}
