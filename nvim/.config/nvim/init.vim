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
Plug 'vim-syntastic/syntastic'
""""    language server protocol
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
""""    snippets support
Plug 'nvim-lua/completion-nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

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
set termguicolors
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
" Transparent background for termguicolors
highlight Normal guibg=none
highlight NonText guibg=none

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
let g:syntastic_mode_map = { 'passive_filetypes': ['python', 'rust'] }
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
"
" Golang
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
"
" Rust
let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
let g:tagbar_type_rust = {
  \ 'ctagsbin' : '/usr/bin/ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'kind2scope' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
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

" nvim-lua/completion-nvim
"
let g:completion_enable_snippet = 'UltiSnips'
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" use <Tab> as trigger keys
"imap <Tab> <Plug>(completion_smart_tab)
"imap <S-Tab> <Plug>(completion_smart_s_tab)
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
" Avoid showing message extra message when using completion
set shortmess+=c
" configure LSP ( https://github.com/neovim/nvim-lspconfig#rust_analyzer )
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable clangd
nvim_lsp.clangd.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Enable type inlay hints
autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
\ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

" :Terminal will open terminal in a new horizontal split below current buffer
command! -nargs=* -bang -complete=file Terminal belowright 20%split +terminal<bang> <args>

