" -----------------------------------------------------------------
" COMPILING A COMPATIBLE VIM {{{
" -----------------------------------------------------------------

" git clone https://github.com/vim/vim.git
" cd vim/
" PATH="/usr/local/Cellar/python3/3.7.3/Frameworks/Python.framework/Versions/3.7/bin:${PATH}" # This is the place on that must match the config directory
" rm src/auto/config.cache
" ./configure --with-features=huge --enable-multibyte --enable-python3interp=yes --with-python3-config-dir=/usr/local/Cellar/python3/3.7.3/Frameworks/Python.framework/Versions/3.7/lib/python3.7/config-3.7m-darwin/ --enable-cscope --enable-rubyinterp
" make
" sudo make install
"
" install ctags:
" wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
" tar -zxvf ctags-5.8.tar.gz
" cd ctags && ./configure && make && sudo make install

" my leader is space:
let mapleader = "\<Space>"

" -----------------------------------------------------------------
" }}} VIM-PLUG {{{
" -----------------------------------------------------------------

" this downloads vim-plug if its missing
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif

" declare plugins
silent! if plug#begin()

    Plug        'ekiefl/auto-pairs'
    Plug      'ctrlpvim/ctrlp.vim'
    Plug       'morhetz/gruvbox'
    Plug   'davidhalter/jedi-vim'
    Plug        'sjbach/lusty'
    Plug    'scrooloose/nerdtree'
    Plug      'jalvesaq/Nvim-R'
    Plug     'tmhedberg/SimpylFold'
    Plug 'vim-syntastic/syntastic'
    Plug     'godlygeek/tabular'
    Plug    'majutsushi/tagbar'
    Plug   'vim-airline/vim-airline'
    Plug   'vim-airline/vim-airline-themes'
    Plug         'tpope/vim-fugitive'
    Plug      'airblade/vim-gitgutter'
    Plug         'tpope/vim-surround'

  call plug#end()
endif

" -----------------------------------------------------------------
" }}} auto-pairs  {{{  # pairs chars, see ~/.vim/after/indent/python.vim
" -----------------------------------------------------------------

" pressing enter at {|} where | is cursor position not working?
" https://github.com/jiangmiao/auto-pairs/issues/215
"
" -----------------------------------------------------------------
" }}} ctrlp.vim  {{{  # fuzzy file/buf search
" -----------------------------------------------------------------

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'

" -----------------------------------------------------------------
" }}} gruvbox  {{{  # retro color scheme
" -----------------------------------------------------------------

colorscheme gruvbox
let g:gruvbox_contrast_dark = 'medium' " soft, medium and hard.
set background=dark " dark or light

" -----------------------------------------------------------------
" }}} jedi-vim  {{{  # python autocompletion
" -----------------------------------------------------------------

inoremap <expr> <C-j>     pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k>     pumvisible() ? "\<C-p>" : "\<C-k>"

let g:jedi#use_splits_not_buffers = ''
let g:jedi#popup_on_dot = 0
let g:jedi#documentation_command = 'R'
let g:jedi#smart_auto_mappings = 0
let g:jedi#completions_command = "<C-N>"
let g:jedi#auto_close_doc = 0

" req'd for g:jedi#show_call_signatures=2
" normally removes INSERT/VISUAL/NORMAL mode info,
" but not with airline plugin
:set noshowmode
let g:jedi#show_call_signatures = '2' " place in cmd line

" toggle autopopup on an off (useful when files are big)
function TogglePopup()
    let popup_status = g:jedi#popup_on_dot
    if popup_status == 0
        let g:jedi#popup_on_dot = 1
    else
        let g:jedi#popup_on_dot = 0
    endif
endfunction
nnoremap <leader>. :call TogglePopup()<cr>

" -----------------------------------------------------------------
" }}} lusty  {{{  # grep all buffers (<leader>lg)
" -----------------------------------------------------------------

" suppress 'you don't have ruby so lusty wont work' msg
let g:LustyJugglerSuppressRubyWarning = 1

" -----------------------------------------------------------------
" }}} nerdtree  {{{  # file explorer
" -----------------------------------------------------------------

map <leader>o :NERDTree<CR>
let NERDTreeShowLineNumbers=1

" -----------------------------------------------------------------
" }}} Nvim-R {{{  #  turn vim into an R environment
" -----------------------------------------------------------------

let R_assign=0 " dont replace _ with <-, i am a big boy

" -----------------------------------------------------------------
" }}} SimpylFold {{{  # folding
" -----------------------------------------------------------------

let g:SimpylFold_fold_import = 0
let g:SimpylFold_fold_docstring = 0
hi Folded ctermfg=109
set nofoldenable
set foldmethod=indent
nnoremap q<tab> zA
nnoremap <tab> za

" -----------------------------------------------------------------
" }}} syntastic {{{  # syntax check for python
" -----------------------------------------------------------------

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['python']
let g:syntastic_enable_highlighting = 1

" -----------------------------------------------------------------
" }}} tabular {{{  # tabularize lines
" -----------------------------------------------------------------

" :'<'>Tab /<delimiter>

" -----------------------------------------------------------------
" }}} tagbar {{{  # search files using tags (e.g. methods, classes)
" -----------------------------------------------------------------

let g:tagbar_left = 1
let g:tagbar_show_linenumbers = 0
let g:tagbar_width = 30
map <leader>t :TagbarToggle<CR>

" -----------------------------------------------------------------
" }}} vim-airline {{{  # beefs the status bar
" -----------------------------------------------------------------

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1 " shows buffer tabs
let g:airline#extensions#tagbar#flags = 'f' " add full tag (shows method AND class in python)

" -----------------------------------------------------------------
" }}} vim-fugitive {{{  # everything git
" -----------------------------------------------------------------

nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gvdiffsplit<CR>
nnoremap <Leader>gp :Gpush<CR>

" -----------------------------------------------------------------
" }}} vim-gitgutter {{{  # + useful for partial file staging
" -----------------------------------------------------------------

" [c and ]c to find git chunks. <leader>hp to preview hunk in new
" window, saving window stages the hunk

" -----------------------------------------------------------------
" }}} vim-surround {{{  # surround selections with enclosing chars
" -----------------------------------------------------------------

" :'<'>S<enclosing_charater>

" -----------------------------------------------------------------
" }}} 
" -----------------------------------------------------------------

" this allows scripts in the ~/.vim/ftplugin/ folder to be sourced
" if you have python specific stuff, make a ~/.vim/ftplugin/python.vim
filetype plugin on

" this fixes insert mode arrow keys mapping to A B C D
if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
  inoremap <silent> <C-[>OC <RIGHT>
endif

" when running :! commands, this gives access to your aliases
let $BASH_ENV = "~/.bash_aliases"

" Manage the window title for talon contexts, i.e. what kind of file is being edited, what mode is vim in?
autocmd BufEnter * execute "silent !title vim " . expand("%:t")

set nowrap
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

" ' is so much easier to type than ` for markers, that I switch them here
nnoremap ' `
nnoremap ` '
vnoremap ' `
vnoremap ` '

" select what was just pasted
nnoremap gp `[v`]

" << back-indents in command mode <M back-idents to 0
nnoremap <M ^d0
" related: some times you just want to move a line up (mnemonic: Move Up)
nnoremap MU ^d0i<bs><space><esc>

" when exiting insert mode, the marker r is made
inoremap <esc> <esc>mr

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
\ if ! exists("g:leave_my_cursor_position_alone") |
\ if line("'\"") > 0 && line ("'\"") <= line("$") |
\ exe "normal g'\"" |
\ endif |
\ endif

set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set backspace=indent,eol,start

" source abbreviations
so ~/.vim/abbreviations.vim
so ~/.vim/myscripts.vim

" This defines how fast page up and page down functionality scrolls. A reasonable default is 5000
let g:scroll_factor = 15000

set term=xterm-256color

set nobackup
set nowritebackup
set noswapfile

map <leader>me :set mouse=v<CR>
map <leader>mm :set mouse=a<CR>
set mouse=a
hi SpellBad cterm=underline

set noruler
set laststatus=2

" no automatic word wrap, but `gq` wraps to textwidth
set textwidth=100
set fo-=t

" making space above or below curor's line
"nnoremap <C-u> :call ReturnToOriginalPosition("o")<CR>
"nnoremap <C-i> :call ReturnToOriginalPosition("O")<CR>

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

" shift-left and shift-right switch buffer in normal mode
nnoremap <s-h> :bp!<CR>
nnoremap <s-l> :bn!<CR>

" close a buffer without second thought
map <leader>c :bw!<CR>

set hidden " unknown what this does

set number relativenumber " hybrid line numbering
"set number " absolute numbering
highlight LineNr ctermfg=174

" snakemake syntax highlighting
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

" FASTA fasta highlighting
au BufNewFile,BufRead *.fasta,*.fa,*.fna,*.faa setf fasta

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
    else
        execute 'onoremap in'  . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "i")<CR>'
        execute 'onoremap an'  . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "a")<CR>'
        execute 'onoremap il'  . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "i")<CR>'
        execute 'onoremap al'  . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "a")<CR>'
        execute 'nnoremap vin' . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "i")<CR>'
        execute 'nnoremap van' . delimiter . ' :<C-U>call SmartInner(v:count, 0, "' . delimiter . '", "a")<CR>'
        execute 'nnoremap vil' . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "i")<CR>'
        execute 'nnoremap val' . delimiter . ' :<C-U>call SmartInner(v:count, 1, "' . delimiter . '", "a")<CR>'
    endif
endfor

" vimpyter
autocmd Filetype ipynb nmap <silent><Leader>j :VimpyterStartJupyter<CR>

" -----------------------------------------------------------------
" TERMINAL-MODE; CURRENTLY WAITING FOR BETTER SUPPORT {{{
" -----------------------------------------------------------------
"
"function SetupPaste()
"    silent! normal a<C-w>""
"    "exe '<C-w>""'
"    "sleep 1
"    "terminal! <C-w>N
"endfunction
"
""autocmd BufEnter * if &buftype ==# 'terminal' | nnoremap p a<C-w>""<C-w>N | endif
""autocmd BufLeave * if &buftype ==# 'terminal' | nnoremap p p | endif
"
"function InitShell()
"    set termwinsize=0x75
"    set splitright
"    let g:vimwin = win_getid()
"    vert term ++kill=kill<cr>
"    let g:shellwin = win_getid()
"    nnoremap <leader>b :call win_gotoid(shellwin)<CR>a
"    nnoremap <leader>v :call win_gotoid(vimwin)<CR>
"    tnoremap <C-v> <C-\><C-n>:call win_gotoid(vimwin)<CR>
"    call term_sendkeys("", "source ~/.bash_aliases\<CR>")
"    silent! normal i
"    setlocal nonumber norelativenumber
"endfunction
"
"tnoremap <esc> <C-\><C-n>
"nnoremap <leader>s :call InitShell()<CR>

" -----------------------------------------------------------------
" }}}
" -----------------------------------------------------------------
