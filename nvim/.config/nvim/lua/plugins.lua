require('packer_compiled')
-- disable runtime plugins
vim.g.did_load_filetypes = 1
vim.g.loaded_matchit = 1
vim.g.loaded_newtrPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
--vim.g.loaded_rplugin = 1
--vim.g.loaded_matchparen = 1
vim.g.loaded_shada = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_man = 1
vim.g.loaded_tutor_mode_plugin = 1
--
-- packer plugin manager bootstrap
--
local execute = vim.api.nvim_command
local fn = vim.fn

local packer_install_dir = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
local repo = 'https://github.com/wbthomason/packer.nvim'
local install_cmd = string.format('10split |term git clone --depth=1 %s %s', repo, packer_install_dir)

if fn.empty(fn.glob(packer_install_dir)) > 0 then
  execute(install_cmd)
  execute 'packadd packer.nvim'
end

vim.cmd [[packadd packer.nvim]]

--
-- plugins install
--
require("packer").startup({
  function(use)
    -- speedup lua modules startup
    use({"lewis6991/impatient.nvim", rocks = 'mpack'})
    -- packer
    use({"wbthomason/packer.nvim",
         opt = true
    })
    -- to profile startup time of nvim
    use({"tweekmonster/startuptime.vim"})
    -- faster filetype loading
    --use({"nathom/filetype.nvim", config = [[require("plugins.filetype_nvim")]] })
    -- colorscheme
    use({"tanvirtin/monokai.nvim"})
    -- on steroids
    --   surround
    use({"tpope/vim-surround",
	opt = true
    })
    --   repeat
    use({"tpope/vim-repeat",
	opt = true
    })
    -- IDE look 'n feel
    --   file tree viewer
    use({"preservim/nerdtree",
         opt = true,
	 cmd = {"NERDTreeToggle", "NERDTree"},
         config = [[require("plugins.nerdtree")]]
    })
    --   view buffer functions/definitions
    use({"majutsushi/tagbar",
         opt = true,
	 cmd = {"TagbarToggle", "Tagbar"}
    })
    -- markdown syntax
    use({"plasticboy/vim-markdown",
         opt = true,
	 ft = {"markdown"},
         config = [[require("plugins.vim-markdown")]]
    })
    -- git
    --   +++/--- column of changes
    use({"airblade/vim-gitgutter", config = [[require("plugins.gitgutter")]]})
    --   cmdline
    use({"tpope/vim-fugitive",
         requires = {{"tpope/vim-rhubarb"}},
    })
    -- statusline
    use({"nvim-lualine/lualine.nvim",
         requires = {{"arkav/lualine-lsp-progress"}},
         config = [[require("plugins.lualine")]]
    })
    -- snippets
    use({"SirVer/ultisnips",
         opt = true,
	 ft = {"cpp", "c", "python", "go", "rust", "lua"},
         config = [[require("plugins.ultisnips")]],
	 requires = {{"honza/vim-snippets", opt = true}}
    })
    -- TreeSiter
    use({"nvim-treesitter/nvim-treesitter",
         run = ":TSUpdate",
         config = [[require("plugins.treesitter")]]
    })
    --   autocompletion engine
    use({"hrsh7th/nvim-cmp",
         opt = true,
         ft = {"cpp", "c", "python", "go", "rust", "lua"},
         requires = {
             -- LSP autocompletion
             {"hrsh7th/cmp-nvim-lsp"},
             -- snippets on autocomplete menu
             {"quangnguyen30192/cmp-nvim-ultisnips", opt = true, after = "ultisnips", config = [[require("plugins.nvim_cmp")]]}
         }
    })
    -- LSP
    --   some default configurations for built-in LSP client
    use({"neovim/nvim-lspconfig",
         opt = true,
         after = "cmp-nvim-lsp",
	 config = [[require("plugins.nvim_lspconfig")]]
    })
    -- golang
    use({"fatih/vim-go",
    	 opt = true,
	 ft = {"go"},
    	 run = ":GoInstallBinaries",
         config = [[require("plugins.vim-go")]]
    })
    -- rust
    use({"simrat39/rust-tools.nvim",
        opt = true,
        after = "nvim-lspconfig",
        config = [[require("plugins.rust_tools")]]
    })
    use({"rust-lang/rust.vim",
    	 opt = true,
	 ft = {"rust"},
         config = [[require("plugins.rust_vim")]]
    })
    -- Telescope fuzzy finder
    use({
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}},
        config = [[require("plugins.telescope")]]
    })
    -- github markdown
    use({'yasuhiroki/github-actions-yaml.vim'})
  end,
    config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua'
  }
})
