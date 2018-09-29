"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
	set backupdir=~/.vimback
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set nu
set tabstop=2
set shiftwidth=2
set autoindent		" always set autoindenting on
set wildmode=longest,list,full
set wildmenu

let @p = 'ggO#!/usr/bin/env python2# -*- coding: UTF-8 -*-import sys'
let @b = 'ggO#!/usr/bin/bash'
let @l = 'ggO#!/usr/bin/env perljiuse strict;use warnings;2j'
let @h = '030i#yypO# '
let @c = '0i	30a*yypki/jA/ko'

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
	set omnifunc=syntaxcomplete#Complete

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

 set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

au BufNewFile,BufRead *.frag,*.vert,*.glsl,*.shader setl filetype=c
au BufNewFile,BufRead *.l,*.y setl filetype=c
au BufWritePost *.coffee CoffeeMake -b
au BufWritePost *.shader !./comp %

au BufNewFile,BufRead *.python,*.py setl sw=4 sts=4 et makeprg=python2
au BufNewFile,BufRead *.sh setl makeprg=bash
au BufNewFile,BufRead *.pl setl makeprg=perl
au BufNewFile,BufRead *.cpp,*c,*.h setl makeprg=make

map Q ZQ
map H gT
map L gt
nmap T :tabnew<cr>
map <c-p> :set nowrap <cr>
map <c-e> :e ++enc=sjis <cr>

nmap <c-c> :w!<cr>:!chmod +x %<cr>:make % <cr>
"au FileType python nmap <c-c> :w! <cr> :!python2 % <cr>

au FileType cpp nmap <F7> : wa! <cr> : silent! make <cr> :cw <cr> :redraw!<cr>
"au FileType glsl nmap <F5> : w! <cr> :! ./comp % <cr>

map <c-k> <c-w>k
map <c-j> <c-w>j
map <c-h> <c-w>h
map <c-l> <c-w>l

let myvar = strftime("(%y%m%d)_%Hh%M")
let myvar = "set backupext=_".myvar
execute myvar

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
set term=xterm-256color

set runtimepath^=~/.vim/bundle/ag
