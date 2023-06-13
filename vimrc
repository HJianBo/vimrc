set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" common plugins
"Plugin 'https://github.com/Yggdroot/LeaderF'
" for erlang
Plugin 'https://github.com/HJianBo/vim-erlang-skeletons'
Plugin 'https://github.com/vim-erlang/vim-erlang-runtime.git'
Plugin 'https://github.com/vim-erlang/vim-erlang-omnicomplete'
" for rust
Plugin 'rust-lang/rust.vim'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

call vundle#end()

set nocompatible
filetype plugin indent on

syntax on

set ruler
set tabstop=4
set shiftwidth=4
set expandtab
set backspace=2
set incsearch
set hlsearch
set cc=100

set background=dark
colorscheme murphy

" vim-erlang-omnicomplete
set cot-=preview

" setup coc-explorer
nmap <space>e <Cmd>CocCommand explorer --root-strategies keep --position=left<CR>

" setup coc.nvim

" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
