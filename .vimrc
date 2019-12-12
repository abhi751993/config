set nocompatible

" Setup vim-plug if not present already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" vim-plug setup complete

call plug#begin('~/.vim/plugged')
Plug 'xolox/vim-misc' " Required for vim-session
Plug 'xolox/vim-session' " Session Manager
Plug 'tpope/vim-fugitive' " Best Plugin on the planet Period
Plug 'vim-scripts/mru.vim' " Most Recently Used
Plug 'w0rp/ale'
Plug 'nvie/vim-flake8'
Plug 'vim-scripts/Command-T'
Plug 'Valloric/YouCompleteMe'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
call plug#end()

" Ale config start
let g:ale_linters = {'python': ['flake8']}
" Ale config end

" YouCompleteMe config start
let g:ycm_python_binary_path = '/usr/bin/python2.7'
let g:ycm_semantic_triggers = {'python': [ 're!\w{2}' ]}
set completeopt-=preview
nnoremap <leader>yd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>yr :YcmCompleter GoToReferences<CR>
" YouCompleteMe config end

" Command-T config start
let g:CommandTMaxHeight = 15
" Command-T config end

" vim-session config start
let g:session_autoload = 'no'
let g:session_autosave = 'yes'
" vim-session config end

" nerdtree config start
autocmd vimenter * NERDTree | wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd FileType javascript setlocal shiftwidth=2 softtabstop=2 expandtab

" nerdtree config end

let mapleader=","
set hidden
set undofile
set undodir=~/.vim/undodir
set number
set relativenumber
set path+=**
set wildmenu
set ruler
set laststatus=2
set tabstop=4
set expandtab
set colorcolumn=120
set hlsearch
set shiftwidth=4
set showmatch
set backspace=indent,eol,start
set autoread
set backupdir=~/.vim/backup
set directory=~/.vim/backup
set showcmd
set showmode
set autoread
set incsearch
set scrolloff=5
set nocursorline
set smartcase
set wildignore=*pyc
set wildignore+=neoapifp/node_modules/
set ignorecase
" =============== Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

iabbrev review gaurav.k, amar, jai_thakkar, heena.g, vandana.j, sj247, dinesh.k " :)
iabbrev syso System.out.println

set statusline=%{fugitive#statusline()}\ [%<%.99f%h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}]\ %h%m%r%y%=%c,%l/%L\ %P

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR>

" Disable Arrow keys in Normal mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nnoremap - ddp
nnoremap _ kddpk
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
nnoremap <leader>b :Gblame<CR>
nnoremap <leader>n :cnext<CR>
nnoremap <leader>p :cprevious<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>a i<cr><esc>3w
nnoremap <leader>q :ccl<cr>
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>
nnoremap gn :bn<cr>
nnoremap gp :bp<cr>
nnoremap gd :bd<cr>


" Close tabs to the left and right
function! TabCloseRight(bang)
    let cur=tabpagenr()
    while cur < tabpagenr('$')
        exe 'tabclose' . a:bang . ' ' . (cur + 1)
    endwhile
endfunction

function! TabCloseLeft(bang)
    while tabpagenr() > 1
        exe 'tabclose' . a:bang . ' 1'
    endwhile
endfunction

command! -bang Tabcloseright call TabCloseRight('<bang>')
command! -bang Tabcloseleft call TabCloseLeft('<bang>')

" Open current file in Github
noremap <silent> <leader>og V:<c-u>call OpenCurrentFileInGithub()<cr>
xnoremap <silent> <leader>og :<c-u>call OpenCurrentFileInGithub()<cr>

function! OpenCurrentFileInGithub()
  let file_dir = expand('%:h')
  let git_root = system('cd ' . file_dir . '; git rev-parse --show-toplevel | tr -d "\n"')
  let file_path = substitute(expand('%:p'), git_root . '/', '', '')
  let branch = system('git symbolic-ref --short -q HEAD | tr -d "\n"')
  let git_remote = system('cd ' . file_dir . '; git remote get-url origin')
  let repo_path = matchlist(git_remote, ':\(.*\)\.')[1]
  let url = 'https://github.com/' . repo_path . '/blob/' . branch . '/' . file_path
  let first_line = getpos("'<")[1]
  let url .= '#L' . first_line
  let last_line = getpos("'>")[1]
  if last_line != first_line | let url .= '-L' . last_line | endif
  call system('open ' . url)
endfunction

