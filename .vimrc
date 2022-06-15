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
