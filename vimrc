" vimrc
" Author: Martin Klepsch <martinklepsch@gmail.com>

""" TABS AND SPACES
" set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2                   " 2 characters tab
set autoindent
set expandtab
set listchars=tab:⇢\ ,trail:·   " show tabchar and trailing whitespace
set list

""" COMPLETION
set completeopt=longest
set completeopt+=menu,preview

" COMMAND LINE COMPLETION
set wildmenu
set wildmode=longest:full,full

""" FORMATTING OPTIONS
set formatoptions=
set formatoptions+=t           " wrap lines according to textwidth setting
set formatoptions+=n           " Format numbered lists
set formatoptions+=c           " Format comments
set formatoptions+=1           " break before 1-letter words
set formatoptions+=l           " dont break existing long lines
set formatoptions+=r           " continue comments

""" VIM-SPECIFIC SETTINGS
set history=300                " last 300 commands
set bs=indent,eol,start        " backspace as we know it

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Statusline
set laststatus=2
set statusline=\ %<%F[%{&ff}]%h%w%m%r%y%=L:%l/%L\ (%p%%)\ C:%c\
autocmd InsertEnter * hi statusline ctermbg=154 ctermfg=235
autocmd InsertLeave * hi statusline ctermbg=166 ctermfg=235
hi statusline ctermbg=166 ctermfg=235

" Don't do any backups while editing a file
set nobackup
set nowritebackup
set noswapfile

set cursorline                 " highlight cursorline
au FocusLost * :wa             " save file when vim loses focus

set colorcolumn=95            " highlight column 95

" Always display at least 5 lines to the window edge
set scrolloff=5

" Show matching brackets
set showmatch

" Dont break lines wider than the window
" set nowrap
set sidescrolloff=10

" Force myself to not write lines longer than 92 chars
set textwidth=92

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Fast Tab-switching
map <leader>p :tabprevious<cr>
map <leader>n :tabnext<cr>
" also edit shell config fast
map <leader>z :tabe! ~/.zshrc<CR>
" Nerdtree Bindings
map <leader>t :NERDTreeToggle<CR>

" Quick escaping
inoremap kj <ESC>

" show todos
map <leader>l :Ack!"TODO MKL"<CR>

""" SEARCHING
set ignorecase
set incsearch
set smartcase "case sensitive if there is an uppercase letter

let g:ctrlp_working_path_mode = 2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PLUGINS & PATHOGEN
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'slim-template/vim-slim'
Bundle 'mhinz/vim-signify'

" vim-scripts repos
Bundle 'VimClojure'

" non github repos
"Bundle 'git://git.wincent.com/command-t.git'


filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" UNSORTED
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim/vimrc
autocmd! bufwritepost snips.vim source ~/.vim/snips.vim
source ~/.vim/snips.vim

set background=dark
if has('gui_running')
	colorscheme solarized
  set guioptions=
else
	colorscheme lucius
endif
syntax on
set number
set hlsearch

""" Filetype detection
augroup filetypedetect
augroup END
let g:netrw_dirhistmax = 0

" Save folds
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" When run from the fish shell, VIM gives error messages like: "E484: Can't open file
" /tmp/v916556/0"

" The problem occurs because VIM expects to be run from a POSIX shell, although this is
" not mentioned anywhere in the documentation. A workaround is to add the following lines to
" the your local ~/.vimrc or global /etc/vimrc file:
if $SHELL =~ 'bin/fish'
  set shell=/bin/sh
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PLUGIN CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>a :Ack!

" Fugitive
augroup ft_fugitive
    au!
    au BufNewFile,BufRead .git/index setlocal nolist
augroup END

" ctrlp
let g:ctrlp_map = '<leader>,'
let g:ctrlp_dont_split = 'NERD_tree_2'

" Vimclojure
let g:vimclojure#ParenRainbow = 1
let g:vimclojure#HighlightBuiltins = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" FILETYPE SPECIFIC STUFF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.thor set filetype=ruby
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" FUNCTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//e
  ''
:endfunction
autocmd FileWritePre * :call TrimWhiteSpace()
autocmd FileAppendPre * :call TrimWhiteSpace()
autocmd FilterWritePre * :call TrimWhiteSpace()
autocmd BufWritePre * :call TrimWhiteSpace()

" Displays indent guides
let g:indentguides_state = 0
function! IndentGuides() " {{{
    if g:indentguides_state
        let g:indentguides_state = 0
        2match None
    else
        let g:indentguides_state = 1
        execute '2match IndentGuides /\%(\_^\s*\)\@<=\%(\%'.(0*&sw+1).'v\|\%'.(1*&sw+1).'v\|\%'.(2*&sw+1).'v\|\%'.(3*&sw+1).'v\|\%'.(4*&sw+1).'v\|\%'.(5*&sw+1).'v\|\%'.(6*&sw+1).'v\|\%'.(7*&sw+1).'v\)\s/'
    endif
endfunction " }}}
nnoremap <leader>i :call IndentGuides()<cr>

