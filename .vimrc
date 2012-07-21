set autoindent
set shiftround
set backspace=2
set ruler
set tw=0
set shiftwidth=4
set expandtab
set ts=4
set shortmess=aotT
set backupdir=~/BAK
set backup
set bex=.bak
set viewdir=~/view
set incsearch
set efm=%A%f:%l:%m,
        \%C%m,
        \%C%m,
        \%C%m,
        \%C%m
set cpoptions=aABceFsjc
set formatoptions=tcqro
set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
set history=100
set wildmode=list:full
set ignorecase
set smartcase
set foldcolumn=2
set foldmethod=manual
set sessionoptions=buffers,curdir,folds,globals,help,localoptions,options,winpos,winsize,resize,unix
set nowrapscan
set statusline=%<%f\ (%n)\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set titlestring=%t\ (%n)\ %m
set tags=~/Louis/Tracks/PD/pypd/tags,./tags
set splitright
set undofile

set path=.,./**,~/dev/git/**
"set path=.,./**

filetype on
filetype plugin indent on

" highlight spaces at the end of lines
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

let c_syntax_for_h=1

" Misc
noremap Q gq
nnoremap ' `
nnoremap ` '

function! GnuMapUnmap()
    if !exists("g:gnumap")
        let g:gnumap = "unmap"
    endif

    if g:gnumap == "map"
        echo "Gnu Style"

        call GnuMap()
        call GnuIndent()
        let g:gnumap = "unmap"
    else
        echo "ANSI Style"

        call UnGnuMap()
        call UnGnuIndent()
        let g:gnumap = "map"
    endif
endfunction

function! GnuMap()
    map [[ ?^    \zs{:call histdel("search", -1):let @/ = histget("search", -1)
    map ]] /^    \zs{:call histdel("search", -1):let @/ = histget("search", -1)
    map [] ?^    \zs}:call histdel("search", -1):let @/ = histget("search", -1)
    map ][ /^    \zs}:call histdel("search", -1):let @/ = histget("search", -1)
endfunction

function! UnGnuMap()
    unmap [[
    unmap ]]
    unmap []
    unmap ][
endfunction

function! GnuIndent()
    set cinoptions=>4,f1s,{1s,^-2,:1s,=1s,g0,h2,p5,t0,+2,(0,u0,w1,m1,W1s
endfunction

function! UnGnuIndent()
    set cinoptions=>4,(0,w1,W1s
endfunction

call UnGnuIndent()

set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  "return v:folddashes . sub
  return sub
endfunction

"function! Leave()
	"if exists("v:this_session")
        "exe "mksession!" . v:this_session
    "else
        "echo "No session saved"
    "endif
"endfunction

"au VimLeave * call Leave()
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

"au BufWinLeave *.c,*.cpp,*.h,*.java,*.py mkview
"au BufWinEnter *.c,*.cpp,*.h,*.java,*.py silent loadview
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

set nopaste
function! TogglePaste()
    if !exists("g:togglepaste")
        let g:togglepaste = 0
    endif

    if g:togglepaste == 0
        set paste
        let g:togglepaste = 1
        echo "paste on"
    else
        set nopaste
        let g:togglepaste = 0
        echo "paste off"
    endif
endfunction

set nospell
function! ToggleSpell()
    if !exists("g:togglespell")
        let g:togglespell = 0
    endif

    if g:togglespell == 0
        set spell
        let g:togglespell = 1
        echo "spell on"
    else
        set nospell
        let g:togglespell = 0
        echo "spell off"
    endif
endfunction

function! ToggleSyntax()
    if !exists("g:togglesyntax")
        let g:togglesyntax = 0
    endif

    if g:togglesyntax == 0
        syntax on
        hi statement ctermfg=yellow
        hi string ctermfg=grey
        hi PreProc ctermfg=white
        hi special ctermfg=cyan
        hi comment ctermfg=blue guifg=darkblue
        hi Folded ctermfg=7 ctermbg=0
        hi String ctermfg=2 cterm=bold
        hi PythonExceptions ctermfg=1
        hi pythonFunction ctermfg=4 cterm=bold
        hi Constant ctermfg=1 cterm=bold

        let g:togglesyntax = 1
        if g:doecho == 1
            echo "syntax on"
        endif
    else
        syntax off
        let g:togglesyntax = 0
        if g:doecho == 1
            echo "syntax off"
        endif
    endif
endfunction

let g:togglesyntax = 0
let g:doecho = 0
call ToggleSyntax()
let g:doecho = 1



" ---------------- SHORTCUTS -----------------------

let mapleader="\\"

nnoremap    W               :w<CR>
nnoremap    \;              :so %<CR>

" Next file
nnoremap    <leader>n       :n<CR>
nnoremap    <leader>N       :N<CR>
" Grep shortcuts
"map     \g      :grep "<cword>" *.py<CR>
" Turn on syntax highlighting
nnoremap    <leader>h       :call ToggleSyntax()<CR>
nnoremap    <leader>p       :call TogglePaste()<CR>
nnoremap    <leader>z       :call ToggleSpell()<CR>
nnoremap    <leader>[       :call GnuMapUnmap()<CR>
nnoremap    <leader>s       :buffers<CR>
" Shows the highlighting in use for the item under the cursor
map         <leader>H       :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" quotes current word
nnoremap    <leader>"       viw<esc>a"<esc>hbi"<esc>lel<CR>

" Draw line of ----
nnoremap    <leader>l       o75A-0k
nnoremap    <leader>L       o120A-k

" Draw line under current line of text, same length
nnoremap    <leader>k       yyp:.,.s/./-/g<CR>

" Todo list
nnoremap    <leader>to      :e ~/Documents/todo/todo.txt<CR>
" Daily
nnoremap    <leader>da      :e ~/Documents/todo/daily.txt<CR>
" Issues
nnoremap    <leader>i       :e ~/Documents/todo/issue-

nnoremap    <leader>r       :reg<CR>
"
" Grep
nnoremap    <leader>gc      :execute "vimgrep /" . expand("<cword>") . "/" . expand("%:p:h") . "/**"<CR>
nnoremap    <leader>ga      :execute "vimgrep /" . expand("<cword>") . "/ " . expand("~/dev/git") . "/**"<CR>
nnoremap    <leader>e       :%s/\s\+$//g<CR>

" tags
nnoremap    <leader>tn      :tn<CR>
nnoremap    <leader>tp      :tp<CR>
nnoremap    <leader>ts      :ts<CR>

" make errors
nnoremap    <leader>cn      :cn<CR>
nnoremap    <leader>cp      :cp<CR>
nnoremap    <leader>cl      :clist<CR>

nnoremap    <leader>bd      :bdel<CR>
nnoremap    <leader>bw      :bwipe<CR>


" Alt-1 to Alt-9
nnoremap    <leader>1       :b 1<CR>
nnoremap    <leader>2       :b 2<CR>
nnoremap    <leader>3       :b 3<CR>
nnoremap    <leader>4       :b 4<CR>
nnoremap    <leader>5       :b 5<CR>
nnoremap    <leader>6       :b 6<CR>
nnoremap    <leader>7       :b 7<CR>
nnoremap    <leader>8       :b 8<CR>
nnoremap    <leader>9       :b 9<CR>

" Alt-10 to Alt-19
nnoremap    <leader>10      :b 10<CR>
nnoremap    <leader>11      :b 11<CR>
nnoremap    <leader>12      :b 12<CR>
nnoremap    <leader>13      :b 13<CR>
nnoremap    <leader>14      :b 14<CR>
nnoremap    <leader>15      :b 15<CR>
nnoremap    <leader>16      :b 16<CR>
nnoremap    <leader>17      :b 17<CR>
nnoremap    <leader>18      :b 18<CR>
nnoremap    <leader>19      :b 19<CR>

" Alt-20 to Alt-29
nnoremap    <leader>20      :b 20<CR>
nnoremap    <leader>21      :b 21<CR>
nnoremap    <leader>22      :b 22<CR>
nnoremap    <leader>23      :b 23<CR>
nnoremap    <leader>24      :b 24<CR>
nnoremap    <leader>25      :b 25<CR>
nnoremap    <leader>26      :b 26<CR>
nnoremap    <leader>27      :b 27<CR>
nnoremap    <leader>28      :b 28<CR>
nnoremap    <leader>29      :b 29<CR>

" Taglist plguin
map         <leader>tl      :TlistToggle<CR>
let         TlistWinWidth=40
