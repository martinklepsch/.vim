" vimrc
" Author: Martin Klepsch <martinklepsch@gmail.com>

""" TABS AND SPACES
set smarttab
set shiftwidth=4
set tabstop=4                   " 4 characters tab
set autoindent
set noexpandtab                 " dont expand tabs to spaces
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

" Force myself to not write lines longer than 78 chars
set textwidth=92

""" MAPPINGS
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
" Fast Tab-switching
map <leader>p :tabprevious<cr>
map <leader>n :tabnext<cr>
" Fast editing of the .vimrc
map <leader>e :tabe! ~/.vim/vimrc<CR>
" also edit shell config fast
map <leader>z :tabe! ~/.zshrc<CR>
" Nerdtree Bindings
map <leader>t :NERDTreeToggle<CR>

" Quick escaping
inoremap kj <ESC>

""" SEARCHING
set ignorecase
set incsearch
set smartcase "case sensitive if there is an uppercase letter

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
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'mileszs/ack.vim'

" vim-scripts repos
Bundle 'VimClojure'
Bundle 'L9'
Bundle 'FuzzyFinder'

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

set background=dark
if has('gui_running')
	colorscheme solarized
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" PLUGIN BINDINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>a :Ack!
map <leader>b :FufFile **/<cr>
