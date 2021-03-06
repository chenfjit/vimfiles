" General {{{
set nocompatible        " disable vi compatibility
set history=256         " number of things to remember in history
set autowrite           " write on make/shell commands
set autoread
set timeoutlen=250      " time to wait after ESC (default causes an annoying delay)
set clipboard+=unamed   " yanks go on system clipboard instead
set pastetoggle=<F10>   " toggle between paste and normal: for 'safer' pasting from keyboard
set tags=./tags;$HOME   " walk directory tree upto $HOME looking for tags

" modeline
set modeline
set modelines=5         " default number of lines to read for modeline instructions

" backup
set nowritebackup
set nobackup
set directory=/tmp//    " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)

" buffers
set hidden              " the current buffer can be put to the background without writing to disk

" match and search
set hlsearch            " highlight search
set ignorecase
set smartcase           " be sensitive when there's a capital letter
set incsearch

" auto-detect file encoding list
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" }}}

" Formatting {{{
set fo+=o   " automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode
set fo-=r   " do not automatically insert a comment leader after ann enter
set fo-=t   " do not auto-wrap text using textwidth (does not apply to comments)

set wildmode=longest,list   " at command line, complete longest common string, the list alternatives

set backspace=indent,eol,start  " more powerful backspacing

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab       " make tabs into spaces (set by tabstop)
set smarttab        " smarter tab levels

set autoindent
set cindent
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do,for,switch,case

syntax enable
syntax on

filetype plugin indent on   " automatically detect file types
" }}}

" Visual {{{
set number          " line numbers on
set showmatch       " show matching brackets
set matchtime=5     " bracket blinking
set novisualbell    " no blinking
set noerrorbells    " no noise
set t_vb=           " disable any beeps or flashes on error
set ruler           " show ruler
set showcmd         " display an incomplete command at the bottom right corner of the vim window
" set shortmess=atI   " shortens messages

set laststatus=2    " always show status line
set statusline=%<\ %F\ %m%r%y\ [%{&ff}\|%{&fenc}]
set statusline+=%=%-20.((%l,%c%V)/%L%)
set statusline+=%=%-10.(%{strftime('%H:%M')}%)

set foldenable          " turn on folding
set foldmethod=syntax   " fold on the marker
set foldlevel=100       " don't automatically fold anything
set foldopen=block,hor,mark,percent,quickfix,tag    " what movements open folds

" set mouse-=a    " disable mouse
set mousehide   " hide mouse after chars typed

" Add right margin line
" By default, background color of the area outside the margin line is red, which
" is horrible. Add the following line to your colorscheme file to beautify it.
" --> hi ColorColumn guibg=#2d2d2d ctermbg=246
set textwidth=80
let &colorcolumn=join(range(81,999),",")

" }}}

" {{{ command and auto commands
" sudo write
comm! W exec 'w !sudo tee % > /dev/null' | e!

" auto commands
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}   set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*markdown}                        set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG}                              set ft=gitcommit
au BufWritePost .vimrc source ~/.vimrc     " auto reload settings
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif     " restore position in file

au FileType ruby,cpp setlocal ts=2 sts=2 sw=2 expandtab
" }}}

" key mappings {{{
nnoremap <silent> <Leader>e :e! ~/.vimrc<CR>

" buffers
nnoremap <silent> <Leader>- :bd<CR>

" split line (opposite to S-J joining line)
nnoremap <silent> <C-J> gEa<CR><ESC>ew

nnoremap # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
nnoremap * #

set guioptions-=m
set guioptions-=T
set guioptions-=L
set guioptions-=r
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=L <Bar>
        \set guioptions-=r <Bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
        \set guioptions-=L <Bar>
        \set guioptions-=r <Bar>
    \endif<CR>
" }}}

" plugins {{{

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let vundle manage vundle
Bundle 'gmarik/vundle'

" tree explorer
Bundle 'scrooloose/nerdtree'

" molokai color scheme
Bundle 'tomasr/molokai'
" colorscheme molokai
" let g:molokai_original=1

Bundle 'vim-scripts/FencView.vim'

Bundle 'vim-scripts/TabBar'

Bundle 'vim-scripts/taglist.vim'

Bundle 'vim-scripts/grep.vim'
nnoremap <silent> <F3> :Grep<CR>

" }}}
