" init.vim
"
" Configuration catered for Neovim
" Currently, this only supports windows, and 
" there are a lot of gross hard-coded paths
" One day, maybe I'll generalize everything.
" Probably when I move it to another computer.

"
" CONFIGURE Plugins
"

" Define the plugin download directory
call plug#begin('~/.nvim/plugins')

" Helper function for vim-markdown-composer.
" Compiles the source
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'iCyMind/NeoSolarized'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/lightline.vim'
Plug 'arakashic/chromatica.nvim'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'morhetz/gruvbox'
Plug 'scrooloose/syntastic'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'zchee/deoplete-clang'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


"
" DEFINE GENERAL WINDOW BEHAVIOR
"

" Define python env paths, both 3 and 2
" Needed for some remote plugins
let g:python3_host_prog='C:\Users\sok\AppData\Local\Programs\Python\Python36\python.exe'
let g:python_host_prog='C:\Python27\python.exe'

" Set tab spacing
set ts=2 sw=2 et

" Define leader key
let mapleader = ","

" Set highlighting of the line that contains the cursor
set cursorline

" Tabs expand with spaces
set expandtab
set smarttab

" Turn on line numbers
set number

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

" <window sizing>
set winwidth=82
set winminwidth=30

" Set yank buffer to system clipboard
set clipboard=unnamedplus

" Change default split options
set splitbelow
set splitright

" Pane navigation remapping
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
nnoremap <C-h> <C-W>h

" Find merge conflict markers
map <leader>mc /\v^[<\|=>]{7}( .*\|$)<CR>

" map Ctrl-c to copy to clipboard buffer
vnoremap <C-c> "*y


"
" CONFIGURE COLOR SCHEME
"

let g:gruvbox_contrast_dark='hard'
set termguicolors
set background=dark

"colorscheme NeoSolarized
"colorscheme molokai
colorscheme gruvbox


"
" CONFIGURE nathanaelkane/vim-indent-guides
"

let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


"
" CONFIGURE NERDTree
"

" Map ,nt to nerdtree
nmap <leader>nt :NERDTree<cr>

" Don't close NERDTree when a file is opened from it
let NERDTreeQuitOnOpen=0

" Add a bunch of cute icons for git status 
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


"
" CONFIGURE git-gutter
"

" Set update interval to 250 ms
let g:gitgutter_updatetime=250


"
" CONFIGURE Chromatica
"

let g:chromatica#libclang_path='C:\Program Files\LLVM\bin\libclang.dll'
let g:chromatica#enable_at_startup=1


"
" CONFIGURE deoplete
"

" let g:deoplete#enable_at_startup=1
" let g:deoplete#sources#clang#libclang_path='C:\Program Files\LLVM\bin\libclang.dll'
" let g:deoplete#sources#clang#clang_header='C:\Program Files\LLVM\lib\clang'


"
" CONFIGURE Vertical Ruler
"

command! -nargs=* Ruler call DisplayRuler(<f-args>)

function! DisplayRuler(...)
  let setCol = (a:0 >= 1) ? a:1 : 0
 exe 'set colorcolumn=' . setCol 
endfunction


"
" CONFIGURE LIGHTLINE
"

" Don't show default vim status line
set noshowmode

" Set lightline layout
let g:lightline = {
      \ 'colorscheme': 'default',
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
      \ 'separator': { 'left': "", 'right': "" },
      \ 'subseparator': { 'left': "", 'right': "" }
      \ }

"      \ 'separator': { 'left': '', 'right': '' },
"      \ 'subseparator': { 'left': '|', 'right': '|' }


" lightline: helper functions
function! LightLineModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '' : ''
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
		return branch !=# '' ? ' '.branch : ''
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
