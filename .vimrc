" -----------------------------------------------------------------
" COMPILING A COMPATIBLE VIM {{{
" -----------------------------------------------------------------

" git clone https://github.com/vim/vim.git
" cd vim/
" PATH="/usr/local/Cellar/python3/3.7.3/Frameworks/Python.framework/Versions/3.7/bin:${PATH}" # I found this did not work with a conda installation of python. So I used a brew installation
" rm src/auto/config.cache
" ./configure --with-features=huge --enable-multibyte --enable-python3interp=yes --with-python3-config-dir=/usr/local/Cellar/python3/3.7.3/Frameworks/Python.framework/Versions/3.7/lib/python3.7/config-3.7m-darwin/ --enable-cscope --enable-rubyinterp
" make
" sudo make install
"
" install ctags:
" wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
" tar -zxvf ctags-5.8.tar.gz
" cd ctags-5.8 && ./configure && make && sudo make install

" -----------------------------------------------------------------
" }}} SETUP PLUG {{{
" -----------------------------------------------------------------

" this downloads vim-plug if its missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

" -----------------------------------------------------------------
" }}} GLOBAL BASICS {{{
" -----------------------------------------------------------------

let mapleader = "\<Space>"
let maplocalleader = ','

" this allows scripts in the ~/.vim/ftplugin/ folder to be sourced
" e.g. if you have python specific stuff, make a ~/.vim/ftplugin/python.vim
filetype plugin on

set nowrap
" move through wrapped lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

noremap <silent> 0 g0
noremap <silent> $ g$

set ai
set history=750
set undolevels=750
set iskeyword+=_,$,@,%,#,-
syntax on
set hlsearch
set number
set list
set mouse=v

nnoremap <Leader>w :w<CR>
nnoremap <Leader>fq :q!<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>e :e
nnoremap :w<CR> <nop>
nnoremap :q<CR> <nop>
nnoremap :e <nop>
nnoremap <Leader>x :xa<CR>

" easily edit and source vimrc (and bash)
nnoremap <leader>ev :split ~/.vimrc<cr>
nnoremap <leader>eb :split ~/.bashrc<cr>
nnoremap <leader>ea :split ~/.bash_aliases<cr>
nnoremap <leader>ep :split ~/.bash_prompt<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>
nnoremap <leader>et :e ~/.talon/user/<cr>

" moving around splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" CTRL-Y copies to the sys clipboard
set clipboard=unnamed
vnoremap <c-y> "*y

" , is so much easier to type than ` for markers, that I switch them here
nnoremap , `
nnoremap ` '
vnoremap , `
vnoremap ` '

" select what was just pasted
nnoremap gp `[v`]

" select current body
nnoremap ,, {jV}k

" << back-indents in command mode <M back-idents to 0
nnoremap <M ^d0
" related: some times you just want to move a line up (mnemonic: Move Up)
nnoremap MU ^d0i<bs><space><esc>
nnoremap Mu ^d0i<bs><esc>

" when exiting insert mode, the marker f is made
inoremap <esc> <esc>mf

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

" When cycling through an autocomplete menu (any autocomplete menu),
" use ctrl j and k to move through, rather than ctrl n and p
inoremap <expr> <C-j>     pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>     pumvisible() ? "\<C-p>" : "\<C-k>"

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set backspace=indent,eol,start

set nobackup
set nowritebackup
set noswapfile

map <leader>me :set mouse=v<CR>
map <leader>mm :set mouse=a<CR>
set mouse=a
"hi SpellBad cterm=underline

set noruler
set laststatus=2

" no automatic word wrap, but `gq` wraps to textwidth
set textwidth=88
set fo-=t

" add end and start of line bash equivalents
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o><S-i>

" how far away from max cursor position is from window
set so=1

" show cursorline, causes some amout of lag issues, even with ttyfast and lazyredraw
"set cursorline
set ttyfast
set lazyredraw

" redraw when windowed buffers are entered
nnoremap <leader>rd :redraw!<CR>
autocmd BufWinEnter * execute "redraw!"

" shift-h and shift-l switch buffer in normal mode
nnoremap <s-h> :bp!<CR>
nnoremap <s-l> :bn!<CR>

" close a buffer without second thought
map <leader>c :bw!<CR>

set hidden " unknown what this does

set number relativenumber " hybrid line numbering
"set number " absolute numbering
:highlight LineNr ctermfg=173

" snakemake syntax highlighting
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

" FASTA fasta highlighting
au BufNewFile,BufRead *.fasta,*.fa,*.fna,*.faa setf fasta

onoremap u t_

" operate inside or outside delimiters when cursor is not between
let delimiterList = ['(', ')', '[', ']', '<', '>', '{', '}', '"', "'"]
for delimiter in delimiterList
    if delimiter == '"'
        execute "onoremap in"  . delimiter . " :<C-U>call SmartInner(v:count, 0, '" . delimiter . "', 'i')<CR>"
        execute "onoremap an"  . delimiter . " :<C-U>call SmartInner(v:count, 0, '" . delimiter . "', 'a')<CR>"
        execute "onoremap il"  . delimiter . " :<C-U>call SmartInner(v:count, 1, '" . delimiter . "', 'i')<CR>"
        execute "onoremap al"  . delimiter . " :<C-U>call SmartInner(v:count, 1, '" . delimiter . "', 'a')<CR>"
        execute "nnoremap vin" . delimiter . " :<C-U>call SmartInner(v:count, 0, '" . delimiter . "', 'i')<CR>"
        execute "nnoremap van" . delimiter . " :<C-U>call SmartInner(v:count, 0, '" . delimiter . "', 'a')<CR>"
        execute "nnoremap vil" . delimiter . " :<C-U>call SmartInner(v:count, 1, '" . delimiter . "', 'i')<CR>"
        execute "nnoremap val" . delimiter . " :<C-U>call SmartInner(v:count, 1, '" . delimiter . "', 'a')<CR>"

        execute "onoremap ji"  . delimiter . " :<C-U>call MultiLineInner(v:count, 0, '" . delimiter . "', 'i')<CR>"
        execute "onoremap ki"  . delimiter . " :<C-U>call MultiLineInner(v:count, 1, '" . delimiter . "', 'i')<CR>"
        execute "onoremap ja"  . delimiter . " :<C-U>call MultiLineInner(v:count, 0, '" . delimiter . "', 'a')<CR>"
        execute "onoremap ka"  . delimiter . " :<C-U>call MultiLineInner(v:count, 1, '" . delimiter . "', 'a')<CR>"
        execute "nnoremap vji" . delimiter . " :<C-U>call MultiLineInner(v:count, 0, '" . delimiter . "', 'i')<CR>"
        execute "nnoremap vki" . delimiter . " :<C-U>call MultiLineInner(v:count, 1, '" . delimiter . "', 'i')<CR>"
        execute "nnoremap vja" . delimiter . " :<C-U>call MultiLineInner(v:count, 0, '" . delimiter . "', 'a')<CR>"
        execute "nnoremap vka" . delimiter . " :<C-U>call MultiLineInner(v:count, 1, '" . delimiter . "', 'a')<CR>"
    else
        execute 'onoremap in'  . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "i")<CR>'
        execute 'onoremap an'  . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "a")<CR>'
        execute 'onoremap il'  . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "i")<CR>'
        execute 'onoremap al'  . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "a")<CR>'
        execute 'nnoremap vin' . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "i")<CR>'
        execute 'nnoremap van' . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "a")<CR>'
        execute 'nnoremap vil' . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "i")<CR>'
        execute 'nnoremap val' . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "a")<CR>'

        execute "onoremap ji"  . delimiter . ' :<C-U>call MultiLineInner(v:count, 0, "' . delimiter . '", "i")<CR>'
        execute "onoremap ki"  . delimiter . ' :<C-U>call MultiLineInner(v:count, 1, "' . delimiter . '", "i")<CR>'
        execute "onoremap ja"  . delimiter . ' :<C-U>call MultiLineInner(v:count, 0, "' . delimiter . '", "a")<CR>'
        execute "onoremap ka"  . delimiter . ' :<C-U>call MultiLineInner(v:count, 1, "' . delimiter . '", "a")<CR>'
        execute "nnoremap vji" . delimiter . ' :<C-U>call MultiLineInner(v:count, 0, "' . delimiter . '", "i")<CR>'
        execute "nnoremap vki" . delimiter . ' :<C-U>call MultiLineInner(v:count, 1, "' . delimiter . '", "i")<CR>'
        execute "nnoremap vja" . delimiter . ' :<C-U>call MultiLineInner(v:count, 0, "' . delimiter . '", "a")<CR>'
        execute "nnoremap vka" . delimiter . ' :<C-U>call MultiLineInner(v:count, 1, "' . delimiter . '", "a")<CR>'
    endif
endfor

" Terminal mode
tnoremap kj <C-w>N

" -----------------------------------------------------------------
" CHOOSE YOUR CHARACTER {{{
" -----------------------------------------------------------------

if filereadable(expand("~/.vimrc_abc"))
  so ~/.vimrc_abc
elseif filereadable(expand("~/.vimrc_some_other_config"))
  so ~/.vimrc_some_other_config
else
  so ~/.vimrc_default
endif

" -----------------------------------------------------------------
" }}}
" -----------------------------------------------------------------
