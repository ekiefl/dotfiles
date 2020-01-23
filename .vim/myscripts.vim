" executes an execute command, then returns to previous cursor position
function! ReturnToOriginalPosition(string)
    execute "normal! mq" . a:string . "\<esc>`q"
endfunction

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

function! SearchAndReplace(...)
  let global = a:1

  if global
      let span = "%"
  else
      let span = ""
  endif

  call inputsave()
  let search = input('Search for: ')
  call inputrestore()
  if empty(search)
    return
  endif

  call inputsave()
  let replace = input('Replace with: ')
  call inputrestore()
  if empty(replace)
    return
  endif


  execute "normal! :" . span . "s/" . search . "/" . replace . "/g\<cr>"
endfunction

nnoremap <leader>ss :call SearchAndReplace(0)<cr>
nnoremap <leader>gg :call SearchAndReplace(1)<cr>

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------
"
" adds shebang to new files
" https://github.com/LinuxSDA/HashBang/blob/master/Hashbang
function! Hashbang(portable, permission, RemExt)
let shells = { 
        \    'awk': "awk",
        \     'sh': "bash",
        \    'mak': "make",
        \     'js': "node",
        \     'py': "python",
        \      'R': "Rscript",
        \     'rb': "ruby",
        \    }

let extension = expand("%:e")

if has_key(shells,extension)
    let fileshell = shells[extension]

    if a:portable
        let line =  "#! /usr/bin/env " . fileshell 
    else 
        let line = "#! " . system("which " . fileshell)
    endif

    0put = line

    if a:permission
        :autocmd BufWritePost * :autocmd VimLeave * :!chmod u+x %
    endif


    if a:RemExt
        :autocmd BufWritePost * :autocmd VimLeave * :!mv % "%:p:r"
    endif

endif

endfunction

:autocmd BufNewFile *.* :call Hashbang(1,1,0)

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" Generalization of vi" that can select between delimiters the cursor is not yet between. 
" If a count is not specified 1 is assumed.
function! SmartInner(count, backwards, delimiter, inner_or_outer)
    " if number was not supplied, assume one
    :let number = a:count
    :if number == 0
    :   let number = 1
    :endif

    " which direction are we going to search? (determined by a:backwards)
    :if a:backwards
    :   let dir = "F"
    :else
    :   let dir = "f"
    :endif

    " since the left/right are the same for quotes, you have to search through more
    :if a:delimiter == "'"
    :   let number = 2 * number
    :endif
    :if a:delimiter == '"'
    :   let number = 2 * number
    :endif

    execute 'normal! ' . number . dir . a:delimiter . 'v' . a:inner_or_outer . a:delimiter
    endfunction

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

" Smooth Scroll (from http://www.vim.org/scripts/script.php?script_id=1601, script version 1.0)
"
" Remamps 
"  <C-U>
"  <C-D>
"  <C-F>
"  <C-B>
"
" to allow smooth scrolling of the window. I find that quick changes of
" context don't allow my eyes to follow the action properly.
"
" The global variable g:scroll_factor changes the scroll speed.
"
"
" Written by Brad Phelan 2006
" http://xtargets.com
let g:scroll_factor = 5000
function! SmoothScroll(dir, windiv, factor)
   let wh=winheight(0)
   let i=0
   while i < wh / a:windiv
      let t1=reltime()
      let i = i + 1
      if a:dir=="d"
         "normal j
         execute "normal! \<c-e>j"
      else
         "normal k
         execute "normal! \<c-y>k"
      end
      redraw
      while 1
         let t2=reltime(t1,reltime())
         if t2[1] > g:scroll_factor * a:factor
            break
         endif
      endwhile
   endwhile
endfunction
map <S-j> :call SmoothScroll("d", 2, 2)<cr>
map <S-k> :call SmoothScroll("u", 2, 2)<cr>
map <S-d> :call SmoothScroll("d", 1, 1)<cr>
map <S-u> :call SmoothScroll("u", 1, 1)<cr>

" -----------------------------------------------------------------------------
" -----------------------------------------------------------------------------

"augroup send_to_term
"  autocmd!
"  autocmd TerminalOpen * if &buftype ==# 'terminal' |
"        \   let t:send_to_term = +expand('<abuf>') |
"        \ endif
"augroup END
"
"function! s:op(type, ...)
"  let [sel, rv, rt] = [&selection, @@, getregtype('"')]
"  let &selection = "inclusive"
"
"  if a:0 
"    silent exe "normal! `<" . a:type . "`>y"
"  elseif a:type == 'line'
"    silent exe "normal! '[V']y"
"  elseif a:type == 'block'
"    silent exe "normal! `[\<C-V>`]y"
"  else
"    silent exe "normal! `[v`]y"
"  endif
"
"  call s:send_to_term(@@)
"
"  let &selection = sel
"  call setreg('"', rv, rt)
"endfunction
"
"function! s:send_to_term(keys)
"  let bufnr = get(t:, 'send_to_term', 0)
"  if bufnr > 0 && bufexists(bufnr) && getbufvar(bufnr, '&buftype') ==# 'terminal'
"    let keys = substitute(a:keys, '\n$', '', '')
"    call term_sendkeys(bufnr, keys . "\<cr>")
"    echo "Sent " . len(keys) . " chars -> " . bufname(bufnr)
"    echo keys
"  else
"    echom "Error: No terminal"
"  endif
"endfunction
"
"command! -range -bar SendToTerm call s:send_to_term(join(getline(<line1>, <line2>), "\n"))
"nmap <script> <Plug>(send-to-term-line) :<c-u>SendToTerm<cr>
"nmap <script> <Plug>(send-to-term) :<c-u>set opfunc=<SID>op<cr>g@
"xmap <script> <Plug>(send-to-term) :<c-u>call <SID>op(visualmode(), 1)<cr>
"
"nmap yrr <Plug>(send-to-term-line)
"nmap yr <Plug>(send-to-term)
"xmap R <Plug>(send-to-term)

