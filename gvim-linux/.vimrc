set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'tomtom/tcomment_vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'godlygeek/tabular'
Plugin 'itchyny/lightline.vim'
Plugin 'lilydjwg/colorizer'
Plugin 'sheerun/vim-polyglot'
Plugin 'jplaut/vim-arduino-ino'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10

" Set yank buffer to system clipboard
set clipboard=unnamedplus

" Set leader character
let mapleader = ","

" Map ,nt to nerdtree
nmap <leader>nt :NERDTree<cr>

" Set highlighting of the line that contains the cursor
set cursorline

" Maximize vim on startup (WINDOWS ONLY)
" au GUIEnter * simalt ~x

set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

" Force 256 color mode
set t_Co=256
" Change default split options
set splitbelow
set splitright

" Set syntax and background
syntax enable

set list
set listchars=tab:▸\ ",eol:¬

set virtualedit=onemore

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf8,prc

set expandtab
set smarttab

" Turn on line numbers
set number  

" Find merge conflict markers
map <leader>mc /\v^[<\|=>]{7}( .*\|$)<CR>

" Show 5 lines of context around the cursor.
set scrolloff=5

" Set the terminal's title
set title

" fuck swapfiles, i think
set noswapfile 

" Sane indentation after carriage return
set autoindent

" Global tab width.
set tabstop=2

" And again, related.
set shiftwidth=2

" Make yanking possible across windows
set clipboard+=unnamed

" <window sizing>
set winwidth=82
set winminwidth=30

" Set firewatch color theme
" colorscheme firewatch

" Set Predawn color theme
" colorscheme predawn

" Set wombat color theme
" colorscheme wombat256mod 

" Set gruvbox color scheme
let g:gruvbox_contrast_dark='hard'
set background=dark
colorscheme gruvbox

" Set solarized color theme
" let g:solarized_termcolors=256
" colorscheme solarized
" set background=dark

" Make pane navigation easier
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" map Ctrl-c to copy to clipboard buffer
vnoremap <C-c> "*y

" lightline: set fancy characters
" font patcher and instructions: https://github.com/Lokaltog/vim-powerline/tree/develop/fontpatcher
set laststatus=2

set ts=2 sw=2 et

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1

set noshowmode

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'modified': 'LightLineModified',
      \   'readonly': 'LightLineReadonly',
      \   'fugitive': 'LightLineFugitive',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'separator': { 'left': '⮀', 'right': '⮂' },
      \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
      \ }

" lightline: helper functions
function! LightLineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
endfunction

function! LightLineFilename()
	return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
	       \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
	       \  &ft == 'unite' ? unite#get_status_string() :
	       \  &ft == 'vimshell' ? vimshell#get_status_string() :
	       \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
	       \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
		let branch = fugitive#head()
		return branch !=# '' ? '⭠ '.branch : ''
	endif
	return ''
endfunction

function! LightLineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
