" =================== Pathogen Initialization ==================

call pathogen#infect()
call pathogen#helptags()


" =================== General Config ==================

set encoding=utf-8
colorscheme solarized
set background=dark
set guifont=Menlo:h12
set guioptions-=T "hide toolbar in Macvim
set number
set autoread "reload files changed outside vim
set hidden "supress warnings about unsaved changes in hidden buffers 
set ruler "show ruler by default
set ignorecase
set smartcase
"set cursorline
"set mouse=

" highlight characters in lines that are over 120 chars long
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%121v.\+/
"
augroup vimrc_autocmds
  autocmd BufEnter *.rb highlight OverLength ctermbg=red ctermfg=white guibg=#592929
  autocmd BufEnter *.rb match OverLength /\%129v.\+/
augroup END

" ================= Turn Off Swap Files ==================
set noswapfile
set nobackup
set nowb
:nnoremap <leader>g :silent execute "grep! -R " . shellescape(expand("<cWORD>")) . " ."<cr>:copen<cr>

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

"set nowrap "don't wrap lines
set linebreak "wrap lines at convenient places

syntax on
filetype plugin indent on

" ctrlp settings
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40

set wildignore+=*/vendor/**
set wildignore+=*/log/**

"from within curly braces, insert a new line and indent
inoremap <C-Return> <CR><CR><C-o>k<Tab>

" filetype specific settings settings
augroup indent_and_whitespace_group
  autocmd!
  autocmd FileType ruby setlocal ts=2 sw=2 expandtab number
  autocmd FileType html setlocal ts=2 sw=2 expandtab number
  autocmd FileType mustache setlocal ts=2 sw=2 expandtab number
  autocmd FileType javascript setlocal ts=2 sw=2 expandtab number
  autocmd FileType coffee setlocal ts=2 sw=2 expandtab number
  autocmd FileType vim setlocal ts=2 sw=2 foldmethod=marker
augroup END
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby

"strip trailing whitespace on save for certain files
"(add more file types seperated by commas)
autocmd FileType ruby autocmd BufWritePre <buffer> :%s/\s\+$//e

let mapleader = ","

"incremental search
nnoremap <leader><space> :noh<cr>
set incsearch
set showmatch
set hlsearch

" easier window switching mappings
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"used for vim-powerline plugin for statusline
let g:Powerline_symbols = 'fancy'

"fast saving
nnoremap <leader>w :w!<cr>

"treat long lines as break lines (useful when moving around in them)
noremap j gj
noremap k gk

nnoremap <leader>at :AlternateToggle<cr>
nnoremap <leader>av :AlternateVerticalSplit<cr>
nnoremap <leader>as :AlternateHorizontalSplit<cr>
" space in a fold to toggle fold
autocmd Syntax ruby setlocal foldmethod=syntax
autocmd Syntax ruby normal zR
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" copy current filename into system clipboard - mnemonic: (c)urrent(f)ilename
" this is helpful to paste someone the path you're looking at
nnoremap <silent> <leader>cf :let @* = expand("%:~")<CR>
nnoremap <silent> <leader>cn :let @* = expand("%:t")<CR>

" Use numbers to pick the tab you want (like iTerm)
noremap <silent> <D-1> :tabn 1<cr>
noremap <silent> <D-2> :tabn 2<cr>
noremap <silent> <D-3> :tabn 3<cr>
noremap <silent> <D-4> :tabn 4<cr>
noremap <silent> <D-5> :tabn 5<cr>
noremap <silent> <D-6> :tabn 6<cr>
noremap <silent> <D-7> :tabn 7<cr>
noremap <silent> <D-8> :tabn 8<cr>
noremap <silent> <D-9> :tabn 9<cr>

"return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"remember info about open buffers on close
set viminfo^=%

"disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" Always show the status line
set laststatus=2

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

" CtrlP mappings
nnoremap <leader>t :CtrlP<CR>
nnoremap <leader>m :CtrlPMRU<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" edit and source vimrc and gvimrc mappings
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>sgv :source $MYGVIMRC<cr>

" H should go to beginning of line, L to the end
nnoremap <leader>H ^
nnoremap <leader>L g_

inoremap jk <esc>

nnoremap <leader>ra :call RunCurrentSpecFile()<cr>
nnoremap <leader>rc :call RunNearestSpec()<cr>
"let g:rspec_runner = "ox_x_iterm"


" Put swap files in ~/tmp/.vim
set backupdir=~/tmp/.vim
set directory=~/tmp/.vim

" Enable matchit plugin (needed for ruby-matchit to work)
runtime macros/matchit.vim

autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" abbreviations
iabbrev rjk Ryan Kannegiesser
iabbrev rpry require 'pry';binding.pry

" helper functions
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
