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
"set cc=100

function! SyncTheme()
    let l:scheme = system('gsettings get org.gnome.desktop.interface color-scheme') =~# 'prefer-dark' ? 'habamax' : 'delek'
    if get(g:, 'colors_name', '') !=# l:scheme
        execute 'colorscheme ' . l:scheme
    endif
endfunction

call SyncTheme()
autocmd FocusGained * call SyncTheme()

" Prewarm ELP when Vim starts on an Erlang/rebar project directory (e.g. vim .).
function! s:CloseWarmWindow(warm, timer) abort
    if win_id2win(a:warm) > 0
        call win_execute(a:warm, 'close')
    endif
endfunction

function! s:WarmErlangProject() abort
    if get(g:, 'elp_warm_started', 0) || !isdirectory(expand('%:p'))
        return
    endif
    let l:root = get(systemlist('git -C ' . shellescape(getcwd()) . ' rev-parse --show-toplevel'), 0, '')
    if empty(l:root) || !filereadable(l:root . '/rebar.config')
        return
    endif
    let l:relative = get(systemlist('git -C ' . shellescape(l:root) . " ls-files -- '*.erl'"), 0, '')
    if empty(l:relative)
        return
    endif
    let g:elp_warm_started = 1
    let l:current = win_getid()
    botright vertical new
    execute 'silent keepalt keepjumps edit ' . fnameescape(l:root . '/' . l:relative)
    setlocal nobuflisted
    vertical resize 1
    let l:warm = win_getid()
    call win_gotoid(l:current)
    call timer_start(200, function('s:CloseWarmWindow', [l:warm]))
endfunction

autocmd BufEnter * call timer_start(500, {-> s:WarmErlangProject()})

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
set signcolumn=auto

" GoTo code navigation
function! JumpDefinition(error, locations) abort
    if !empty(a:error) || empty(a:locations)
        return
    endif
    if len(a:locations) != 1
        call CocActionAsync('jumpDefinition', 'vsplit')
        return
    endif
    let l:location = a:locations[0]
    let l:uri = get(l:location, 'uri', get(l:location, 'targetUri', ''))
    let l:path = substitute(substitute(l:uri, '^file://', '', ''), '%20', ' ', 'g')
    let l:range = get(l:location, 'range', get(l:location, 'targetSelectionRange', {}))
    if l:path !=# expand('%:p')
        execute 'vsplit ' . fnameescape(l:path)
    endif
    call cursor(l:range.start.line + 1, l:range.start.character + 1)
endfunction

nmap <silent> gd :call CocActionAsync('definitions', function('JumpDefinition'))<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

"--------------------------------------------------------------------
" setup fzf.vim
function! FzfProjectFiles()
    let l:root = systemlist('git rev-parse --show-toplevel')[0]
    call fzf#vim#files(l:root, fzf#vim#with_preview({
                \ 'source': 'git ls-files -z; find _build/default/lib -type f -print0 2>/dev/null',
                \ 'options': '--read0'
                \ }))
endfunction
nmap <C-p> :call FzfProjectFiles()<CR>
nmap <C-\> :Files<CR>
nmap <C-b> :Buffers<CR>
