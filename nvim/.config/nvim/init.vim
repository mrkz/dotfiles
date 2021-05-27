" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

""""
""""  Declare the list of plugins.
""""

""""  UI/Theme/Colors related
Plug 'tomasr/molokai'


"""" Plugins

""""    surround vim motion
Plug 'tpope/vim-surround'
""""    repeat on steroids
Plug 'tpope/vim-repeat'

""""    navigation (code/tree)
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle'] }
""""    markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

""""    golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

""""    git stuff
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

""""    IDE-like behavior
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mattn/vim-lsp-settings'
Plug 'vim-syntastic/syntastic'
""""    language server protocol
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
""""    snippets support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'thomasfaingnaert/vim-lsp-snippets'
Plug 'thomasfaingnaert/vim-lsp-ultisnips'

""""    statusline
Plug 'vim-airline/vim-airline'

""""    Rust
Plug 'rust-lang/rust.vim'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

set nocompatible
set expandtab
set softtabstop=4
set shiftwidth=4
set background=dark
set ruler
set number
set cursorline
filetype plugin indent on
syntax on

"""" Line number setup
""""    set line number hybrid
set number relativenumber
""""    configure the hybrid for
""""      * absolute number on insert mode
""""      * relative for command mode / buffer not focused
"""" snippet stolen from https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" get backups/swapfiles out of the way
if !isdirectory($HOME . "/.nvim/.bkp")
    call mkdir($HOME . "/.nvim/.bkp", "p")
endif
set backupdir=~/.nvim/.bkp//
set directory=~/.nvim/.bkp//

" set $PATH to use $GOBIN (if available)
if isdirectory($HOME . "/go/bin")
    let $PATH = $HOME . "/go/bin:" . $PATH
endif

""""
"""" Colors setup
""""

" set 80 cols ruler
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#4e6582

" set color theme (REQUIRES molokai SCHEME)
" find it at https://github.com/tomasr/molokai
let g:molokai_original = 1
let g:rehash256 = 1
silent! colorscheme molokai " silent ! ignores error if not installed

" show trailing whitespaces in ugly red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" set groovy syntax for all files named 'jenkinsfile'
au BufNewFile,BufRead Jenkinsfile setf groovy


""""
"""" Plugins setup
""""

" nerdtree
" https://github.com/scrooloose/nerdtree
map <F8> :NERDTreeToggle<CR>
" close vim if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-markdown
" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1

" deoplete.nvim
" https://github.com/Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" vim-go
" https://github.com/fatih/vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"don't complain on older nvim installs
let g:go_version_warning = 0

" syntastic
" https://github.com/vim-syntastic/syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_go_checkers = ['golint', 'gometalineter', 'gotype', 'govet']
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_c_remove_include_errors = 1

" jedi
" https://github.com/davidhalter/jedi-vim
let g:jedi#completions_enabled = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

" tagbar settings
" https://github.com/majutsushi/tagbar
nmap <F9> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" vim-gitgutter
" https://github.com/airblade/vim-gitgutter
let g:gitgutter_max_signs = 1000 " disable after 1000 signs to be shown

" ultisnips (snippets)
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" vim-airline
" https://github.com/vim-airline/vim-airline
let g:airline_symbols_ascii = 1 " use plain ascii symbols
let g:airline_extensions = [] " don't enable any plugin on the statusline by default

" rust.vim
"
let g:rustfmt_autosave = 1
