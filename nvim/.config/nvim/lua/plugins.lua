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
    -- packer
    use({"wbthomason/packer.nvim",
         opt = true
    })
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
    use({"tpope/vim-fugitive"})
    -- statusline
    use({"vim-airline/vim-airline", config = [[require("plugins.airline")]]})
    -- snippets
    use({"SirVer/ultisnips",
         opt = true,
	 ft = {"cpp", "c", "python", "go", "rust", "lua"},
         config = [[require("plugins.ultisnips")]],
	 requires = {{"honza/vim-snippets", opt = true}}
    })
    -- TreeSiter
    use({"nvim-treesitter/nvim-treesitter",
	 run = ":TSUpdate"
    })
    -- golang
    use({"fatih/vim-go",
    	 opt = true,
	 ft = {"go"},
    	 run = ":GoInstallBinaries",
         config = [[require("plugins.vim-go")]]
    })
    -- rust
    use({"rust-lang/rust.vim",
    	 opt = true,
	 ft = {"rust"},
         config = [[require("plugins.rust_vim")]]
    })

  end
})
