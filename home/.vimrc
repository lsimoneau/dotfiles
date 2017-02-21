" Note: 'filetype off' when already off causes a non-zero exit code from vim.
filetype on
filetype off
set runtimepath+=/usr/local/Cellar/go/1.2.2/libexec/misc/vim
filetype plugin indent on

call plug#begin('~/.vim/plugged')
Plug 'nanotech/jellybeans.vim'
Plug 'tpope/vim-fugitive'
Plug 'rking/ag.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
call plug#end()

" Color scheme
set background=dark
colorscheme jellybeans_pda
syntax enable

" vi is dead, long live vim
set nocompatible

" don't bug me about reloading changed files, just do it
set autoread

" Show line numbers
set number

" Visual width of tabs
set tabstop=2 shiftwidth=2

" Make backspace work normally
set backspace=indent,eol,start

" Smart indenting when starting new line
set smartindent

" Indent with two spaces
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

augroup filetype_ruby
  autocmd!
  autocmd FileType ruby setlocal sts=2 ts=2 sw=2 et re=1 foldmethod=manual
augroup END

augroup filetype_rust
  autocmd!
  autocmd FileType rust setlocal sts=4 ts=4 sw=4 et
augroup END

" Ruby whitespace: two spaces, no tabs
" (currently matches global config, remains as reference)
autocmd FileType cucumber setlocal sts=2 ts=2 sw=2 et
autocmd FileType scss setlocal sts=2 ts=2 sw=2 et

" Syntax for Golang
au BufRead,BufNewFile *.go set filetype=go

" Highlight trailing whitespace, but not during insertion
highlight TrailingWhitespace ctermbg=red guibg=red
au BufEnter    * match TrailingWhitespace /\s\+$/
au InsertEnter * match TrailingWhitespace /\s\+\%#\@<!$/
au InsertLeave * match TrailingWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" refresh all buffers
nnoremap <leader>+ :set noconfirm<cr>:bufdo e!<cr>:set confirm<cr>

" Leader of '\' is too far from home row.
let mapleader = ";"
let g:mapleader = ";"

" Fugitive commit / status
nnoremap <leader>c :Gcommit<cr>
nnoremap <leader>s :Gstatus<cr>

" Highlisght search results as you type, <leader><space> to clear
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>

" Strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Convert to Ruby 1.9 hash syntax
noremap <leader>9 :s/:\(\S\+\)\s\+=>\s\+/\1: /g<cr>

let g:VimuxOrientation = "h"
let g:VimuxHeight = "40"

" Ctrl-d to delete prev word in insert mode
imap <C-d> <C-[>diwi

" Ctrl-s to save current buffer
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\|_test.exs\)$') != -1
  if in_test_file
    call SetTestFile()
    call SetTestPrefix("clear;")

    if match(expand('%'), '\.feature$') != -1
      call SetTestRunner("rspec ")
    elseif match(expand('%'), '_spec\.rb$') != -1
      call SetTestRunner("rspec ")
    elseif match(expand('%'), '_test\.exs$') != -1
      call SetTestRunner("mix test ")
    else
      call SetTestRunner("ruby -Ilib:test ")
    endif
  endif
  call VimuxRunCommand(g:bjo_test_prefix . " " . g:bjo_test_runner . g:bjo_test_file)
endfunction

function! SetTestPrefix(prefix)
  let g:bjo_test_prefix=a:prefix
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  call VimuxRunCommand(g:bjo_test_prefix . " " . g:bjo_test_runner . " " . g:bjo_test_file. ":" . g:bjo_test_file_line)
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

" Run the current file with rspec
map <Leader>t :w<cr>:call RunCurrentTest()<CR>
map <Leader>o :w<cr>:call RunCurrentLineInTest()<CR>

" Vimux shortcuts
map <Leader>vq :VimuxCloseRunner<CR>
map <Leader>vz :VimuxZoomRunner<CR>

" Something to do with editing multiple files..?
set hidden

" Jump to matching HTML tag, if/else/endif etc using "%"
runtime macros/matchit.vim

" Navigatable tab completion from Vim command line
set wildmenu

set wildmode=list:longest

" Ignore case in searches, unless search contains upper case
set ignorecase
set smartcase

" Minimum number of lines to keep above/below cursor when scolling
set scrolloff=3

set guicursor=n-c-v:block-nCursor

" No swap files
set noswapfile

" Backup files in a central location, no backup files amongst project.
" Can be a bad idea when editing several files of the same name.
set backupdir=~/.vim/swap
set directory=~/.vim/swap

" Show line and column number, relative scroll position etc.
set ruler

" Use visual bell instead of beeping.
set visualbell

" short info tokens, short command line messages, no intro.
set shortmess=atI

" Number of commands remembered.
set history=1000

" Disable modelines; not used, risk of security exploits.
set modelines=0

" Default to Unicode/UTF-8 rather than latin1
set encoding=utf-8


" Terminals are plenty fast these days.
set ttyfast

" The last window will have a status line: always.
set laststatus=2

" Make j & k sane, instead of archaic “movement by file line instead of screen line”
nnoremap j gj
nnoremap k gk

" save on losing focus
autocmd FocusLost \f\+ :wa

" Quick-edit .vimrc
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>

" Exit insert mode when Vim loses focus.
" A bug prevents this from working: autocmd FocusLost * stopinsert
" See http://stackoverflow.com/questions/2968548
autocmd! FocusLost * call feedkeys("\<C-\>\<C-n>")

" auto-reload .vimrc after save.
autocmd! bufwritepost .vimrc source %

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

" Ctrl-HJKL to navigate split panes
:nmap <silent> <C-h> :wincmd h<CR>
:nmap <silent> <C-j> :wincmd j<CR>
:nmap <silent> <C-k> :wincmd k<CR>
:nmap <silent> <C-l> :wincmd l<CR>

" Mouse for scrolling etc in console.
set mouse=a

" Mapping and escape timeouts.
set timeout
set timeoutlen=1000 " mapped sequences
set ttimeoutlen=10  " escape sequence delay

set clipboard=unnamed

function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

command! TagFiles :call EchoTags()
function! EchoTags()
  echo join(split(&tags, ","), "\n")
endfunction

""""""""""
" Plugins

" ctrlp.vim
let g:ctrlp_max_height = 16
let g:ctrlp_custom_ignore = ''
let g:ctrlp_custom_ignore .= '/\..*/\|'
let g:ctrlp_custom_ignore .= '/tmp/\|'
let g:ctrlp_custom_ignore .= 'REGEX_TERMINATOR'
nnoremap <leader>gs :CtrlP spec/<cr>
nnoremap <leader>gm :CtrlP app/models/<cr>
nnoremap <leader>gv :CtrlP app/views/<cr>
nnoremap <leader>gc :CtrlP app/controllers/<cr>

" NERDTree
nmap <silent> <leader>n :NERDTreeToggle<CR>

" checksyntax: auto-check Ruby files on save.
if !exists('g:checksyntax')
	let g:checksyntax = {}
	let g:checksyntax['ruby'] = {'auto': 1, 'prepare': 'compiler ruby', 'cmd': 'ruby -c', 'okrx': 'Syntax OK\|No Errors'}
endif

" fugitive: Git integration
" empty statusline is equivalent to:
" set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set statusline=%<%f\ %{fugitive#statusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P
