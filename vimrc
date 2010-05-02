"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=300

" Enable filetype plugin
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vim/vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vim/vimrc

colorscheme lucius
syntax enable
set shiftwidth=4

" extend runtimepath, include pathogen
set runtimepath=$HOME/.vim/bundle/vim-pathogen,$VIMRUNTIME
"source all plugins within bundle
call pathogen#runtime_append_all_bundles() 
