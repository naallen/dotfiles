set nocompatible
set spelllang=en_ca
set number
set relativenumber
set whichwrap+=<,>,[,],h,l
set wrap linebreak
set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/syntastic'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'vim-latex/vim-latex'
Plugin 'xolox/vim-misc'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'xolox/vim-notes'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'vim-scripts/vimwiki'
Plugin 'tomasr/molokai'
Plugin 'freitass/todo.txt-vim'
Plugin 'panozzaj/vim-autocorrect'
Plugin 'junegunn/goyo.vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'jplaut/vim-arduino-ino'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'chriskempson/base16-vim'
"Plugin 'colorsupport.vim'
call vundle#end()            " required
filetype plugin indent on    " required

let g:EclimCompletionMethod = 'omnifunc'

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set pastetoggle=<F4>
set tabstop=4
set history=1000
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set shortmess=atToOI

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  set mousemodel=popup
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END



endif " has("autocmd")

set autoindent

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif

nnoremap <F5> :GundoToggle<CR>
nnoremap <F6> :NERDTree %<CR>
noremap <Leader>n :NERDTreeToggle<cr>

set laststatus=2

set background=dark
colorscheme base16-flat
let base16colorspace=256

if has ('gui_running')
  colorscheme base16-default
  set spell
  set guioptions-=T  "remove toolbar
  set guioptions-=r  "remove right-hand scroll bar
  set guifont=Monaco\ for\ Powerline\ 8 
  vmap <C-c> "+yi
  vmap <C-x> "+c
  vmap <C-v> c<ESC>"+p
  imap <C-v> <C-r><C-o>+
endif

let g:airline_powerline_fonts = 1
let g:rehash256 = 1
set background=dark

set modeline

" custom modeline
function! CustomModeLine(cid)
  let i = &modelines
  let lln = line("$")
  if i > lln | let i = lln | endif
  while i>0
    let l = getline(lln-i+1)
    if l =~ a:cid
     exec strpart(l, stridx(l, a:cid)+strlen(a:cid))
    endif
    let i = i-1
  endwhile
endfunction

au BufReadPost * :call CustomModeLine("customvim:")


" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

if $TERM != "linux"
  set t_Co=256
  let g:airline_powerline_fonts = 1
endif

set backupdir=~/vim/tmp,.
set directory=~/vim/tmp,.

source ~/.vim/toggle.vim

let g:vimwiki_list = [{'path': '~/vimwiki/html/', 'auto_export': 1}]
set expandtab
set tabstop=4
set shiftwidth=4
set smartindent

if &term =~ 'rxvt-unicode-256color'
  " solid underscore
  let &t_SI .= "\<Esc>[4 q"
  " solid block
  let &t_EI .= "\<Esc>[2 q"
  " 1 or 0 -> blinking block
  " 3 -> blinking underscore
  " Recent versions of xterm (282 or above) also support
  " 5 -> blinking vertical bar
  " 6 -> solid vertical bar
endif

noremap <F3> :Autoformat<CR>

let g:formatdef_my_custom_cpp = '"astyle --mode=c --indent=spaces=2 --convert-tabs --min-conditional-indent=2 --pad-header --keep-one-line-blocks --keep-one-line-statements --max-instatement-indent=40 --pad-oper"'
let g:formatters_cpp = ['my_custom_cpp']

set encoding=utf-8
let g:Powerline_symbols="fancy"
