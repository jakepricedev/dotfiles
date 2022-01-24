" *****************************************************************************
" Vim Configuration 
" *****************************************************************************

" ==== Plugins ================================================================

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/csv.vim'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'ledger/vim-ledger'
Plug 'pearofducks/ansible-vim'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
call plug#end()

" ==== Visual =================================================================

" Disable menu bar in GVim:
set guioptions-=m

" Disable toolbar in GVim:
set guioptions-=T

" GVim Font:
if has ('gui')
    set guifont=Ubuntu\ Mono\ 14
endif

" MacVim Font:
if has ('gui_macvim')
    set guifont=UbuntuMono-Regular:h16
endif

" Status line:
set laststatus=2
set statusline=%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P

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

if has('nvim') || has('termguicolors')
  set termguicolors
endif

" Set theme:
colorscheme tomorrow_night_blue

" Make default theme readable on dark terminals:
set background=dark

" ==== Functionality ==========================================================

" Set clipboard as system clipboard:
if has("linux")
    set clipboard=unnamedplus
elseif has("mac")
    set clipboard=unnamed
end

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

" Incremental search:
set incsearch

" Stop auto-indenting comments:
set indentkeys-=0#

" ==== Remaps =================================================================

" Switch buffers quickly:
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

" List buffers with fzf:
nnoremap <C-K> :Buffers<CR>

" Search for files with fzf:
" Make sure `stty -ixon` is included in `.bashrc` to reclaim Ctrl S.
noremap <C-S> :Files<CR>

# Common Copy/Paste Shortcuts in GuiVim:
if has ('gui')
    vmap <C-S-c> "+yi
    vmap <C-S-v> c<ESC>"+p
    imap <C-S-v> <C-r><C-o>+
endif

" ==== Extension Settings =====================================================

" vim-markdown settings:
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = ['bash=sh', 'json', 'python', 'css', 'html', 'ini=dosini']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 1

" goyo.vim:
let goyo_width = 80
let goyo_heigh = "100%"

" ==== Custom Functions =======================================================

" Trigger Log todo type state:
function! LogDone()
    %s/types: todo-[a-z0-9]/types: done/g
endfunction

