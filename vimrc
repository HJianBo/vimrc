set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'git://github.com/scrooloose/nerdtree.git'
Plugin 'git://github.com/vim-erlang/vim-erlang-runtime.git'
Plugin 'git://github.com/vim-erlang/vim-erlang-tags.git'
Plugin 'git://github.com/vim-erlang/vim-erlang-omnicomplete.git'
Plugin 'git://github.com/vim-erlang/vim-erlang-skeletons.git'
call vundle#end()
filetype plugin indent on

set nu
set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
filetype plugin indent on
syntax on

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
