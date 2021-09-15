" *****************************************************************************
" Vim Configuration 
" *****************************************************************************

" ==== Plugins ================================================================

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'ledger/vim-ledger'
Plug 'mechatroner/rainbow_csv'
Plug 'pearofducks/ansible-vim'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
call plug#end()

" ==== Visual =================================================================

" Status line:
set laststatus=2
set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P

" MacVim Font:
if has ('gui_macvim')
    set guifont=UbuntuMono-Regular:h16
endif

" Turn off visual bell:
set visualbell
set t_vb=

" Turn on line numbers:
set number

" Turn on cursor line:
set cursorline

" Word wrapping:
set wrap linebreak nolist

" Indents word-wrapped lines as much as the 'parent' line:
set breakindent

" Ensures word-wrap does not split words
set formatoptions=l
set lbr

" Tab indentation:
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" ==== Colour =================================================================

" Enable Challenger Deep Theme:
colorscheme challenger_deep

" Make default theme readable on dark terminals:
set background=dark

" True colours:
if (has("termguicolors"))
  set termguicolors
endif

" ==== Functionality ==========================================================

" MacOS Clipboard:
set clipboard=unnamed

" Allow backspace over everything:
set backspace=indent,eol,start

" File encoding:
set encoding=utf-8

" Mouse mode:
set ttymouse=sgr
set mouse=a

" Keep undo history when switching buffer:
set hidden

" Turn backup off:
set nobackup
set nowb
set noswapfile

" Incremental search.
set incsearch

" ==== Remaps =================================================================

" Switch buffers quickly:
:nnoremap <C-N> :bn<CR>
:nnoremap <C-P> :bp<CR>

" List buffers with fzf:
:nnoremap <C-K> :Buffers<CR>

" Search for files with fzf:
" Make sure `stty -ixon` is included in `.bashrc` to reclaim Ctrl S.
:noremap <C-S> :Files<CR>

" ==== Extension Settings =====================================================

" vim-markdown settings:
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['bash=sh', 'json', 'python', 'css', 'html', 'ini=dosini']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 2

