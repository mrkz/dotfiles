set nocompatible
set expandtab
set softtabstop=4
set shiftwidth=4
set background=dark
set ruler
set number
filetype plugin indent on

" get backups/swapfiles out of the way
set backupdir=~/.vim/bkp//
set directory=~/.vim/bkp//


""""
"""" Colors setup
""""

" set 80 cols ruler
let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#4e6582

" show trailing whitespaces in ugly red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" set color theme (REQUIRES molokai SCHEME)
" find it at https://github.com/tomasr/molokai
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai


""""
"""" Plugins setup
""""

" run path manipulation
" vim-pathogen is used, more details:
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" nerdtree
" https://github.com/scrooloose/nerdtree
map <F9> :NERDTreeToggle<CR>
" close vim if the only window left is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-markdown
" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1

" neocomplete
" https://github.com/Shougo/neocomplete.vim
let g:neocomplete#enable_at_startup = 1

" vim-go
" https://github.com/fatih/vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

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
let g:syntastic_check_on_wq = 1

" jedi
" https://github.com/davidhalter/jedi-vim
let g:jedi#completions_enabled = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

" tagbar settings
" https://github.com/majutsushi/tagbar
nmap <F8> :TagbarToggle<CR>
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

