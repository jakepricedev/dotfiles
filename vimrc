" *****************************************************************************
" Vim Configuration 
" *****************************************************************************

" ==== Install Vim Plug & Missing Plugins ====================================

" Install vim-plug if not found:
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins:
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" ==== Plugins ================================================================

call plug#begin('~/.vim/plugged')
" Plugins that shouldn't be installed on my servers:
if $IS_A_SERVER == 0
    Plug 'chrisbra/csv.vim'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'mattn/emmet-vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'wellle/tmux-complete.vim'
endif
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'markonm/traces.vim'
Plug 'pearofducks/ansible-vim'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
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

" Make default theme readable:
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

" Add keyword delimiters:
set iskeyword+=-

" ==== Remaps =================================================================

" Switch buffers quickly:
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

" List buffers with fzf:
nnoremap <C-K> :Buffers<CR>

" Search for files with fzf:
" Make sure `stty -ixon` is included in `.bashrc` to reclaim Ctrl S.
noremap <C-S> :Files<CR>
" Search for lines in buffers with fzf:
noremap <C-F> :Lines<CR>

" Common Copy/Paste Shortcuts in GuiVim:
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
let g:goyo_width = 80
let g:goyo_height = "100%"

" ==== Custom Commands & Functions ============================================

" Trigger Log todo type state:
function! LogDone()
    %s/types: todo-[a-z0-9]/types: done/g
endfunction

" Open a vertical split with a list of all log entries and their titles to
" quickly gf on filenames to open them:
command! Log vnew |
    \ :setlocal nobuflisted buftype=nofile bufhidden=delete noswapfile |
    \ r ! grep "title:" $DOCS_ROOT/log/content/*.md | sed 's/:title:/ /' | sort

