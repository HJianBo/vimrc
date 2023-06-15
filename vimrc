call plug#begin()
" common plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" need to install https://github.com/junegunn/fzf first
" for examples, in macOS, brew install fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" for erlang
Plug 'https://github.com/HJianBo/vim-erlang-skeletons'
Plug 'https://github.com/vim-erlang/vim-erlang-runtime.git'
Plug 'https://github.com/vim-erlang/vim-erlang-omnicomplete'
" for rust
Plug 'rust-lang/rust.vim'

call plug#end()

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
"set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"--------------------------------------------------------------------
" setup fzf.vim
nmap <C-p> :GFiles<CR>
nmap <C-\> :Files<CR>
nmap <C-b> :Buffers<CR>
