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
    if !exists("b:gnumap")
        let b:gnumap = "unmap"
    endif

    if b:gnumap == "map"
        echo "Gnu Style"

        call GnuMap()
        call GnuIndent()
        let b:gnumap = "unmap"
    else
        echo "ANSI Style"

        call UnGnuMap()
        call UnGnuIndent()
        let b:gnumap = "map"
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
    if !exists("b:togglepaste")
        let b:togglepaste = 0
    endif

    if b:togglepaste == 0
        set paste
        let b:togglepaste = 1
        echo "paste on"
    else
        set nopaste
        let b:togglepaste = 0
        echo "paste off"
    endif
endfunction

set nospell
function! ToggleSpell()
    if !exists("b:togglespell")
        let b:togglespell = 0
    endif

    if b:togglespell == 0
        set spell
        let b:togglespell = 1
        echo "spell on"
    else
        set nospell
        let b:togglespell = 0
        echo "spell off"
    endif
endfunction

function! ToggleSyntax()
    if !exists("b:togglesyntax")
        let b:togglesyntax = 0
    endif

    if b:togglesyntax == 0
        syntax on
        hi statement ctermfg=yellow
        hi string ctermfg=grey
        hi PreProc ctermfg=white
        hi special ctermfg=cyan
        hi comment ctermfg=blue guifg=darkblue

        let b:togglesyntax = 1
        if b:doecho == 1
            echo "syntax on"
        endif
    else
        syntax off
        let b:togglesyntax = 0
        if b:doecho == 1
            echo "syntax off"
        endif
    endif
endfunction

let b:togglesyntax = 0
let b:doecho = 0
call ToggleSyntax()
let b:doecho = 1



" ---------------- SHORTCUTS -----------------------

let mapleader="\\"

map     W               :w<CR>

" Next file
map     <leader>n       :n<CR>
map     <leader>N       :N<CR>
" Grep shortcuts
"map     \g      :grep "<cword>" *.py<CR>
" Turn on syntax highlighting
map     <leader>h       :call ToggleSyntax()<CR>
map     <leader>p       :call TogglePaste()<CR>
map     <leader>z       :call ToggleSpell()<CR>
map     <leader>[       :call GnuMapUnmap()<CR>
map     <leader>s       :buffers<CR>

" Draw line of ----
map     <leader>l       o75A-0k
map     <leader>L       o120A-k

" Draw line under current line of text, same length
map     <leader>k       yyp:.,.s/./-/g<CR>

" Todo list
map     <leader>to      :e ~/Documents/todo/todo.txt<CR>
" Daily
map     <leader>da      :e ~/Documents/todo/daily.txt<CR>
" Issues
map     <leader>i       :e ~/Documents/todo/issue-


map     <leader>r       :reg<CR>
"
" Grep
map     <leader>gc      :execute "vimgrep /" . expand("<cword>") . "/" . expand("%:p:h") . "/**"<CR>
map     <leader>ga      :execute "vimgrep /" . expand("<cword>") . "/ " . expand("~/dev/git") . "/**"<CR>
map     <leader>e       :%s/\s\+$//g<CR>

" tags
map     <leader>tn      :tn<CR>
map     <leader>tp      :tp<CR>
map     <leader>ts      :ts<CR>

" make errors
map     <leader>cn      :cn<CR>
map     <leader>cp      :cp<CR>
map     <leader>cl      :clist<CR>

map     <leader>bd      :bdel<CR>
map     <leader>bw      :bwipe<CR>


" Alt-1 to Alt-9
map     <leader>1       :b 1<CR>
map     <leader>2       :b 2<CR>
map     <leader>3       :b 3<CR>
map     <leader>4       :b 4<CR>
map     <leader>5       :b 5<CR>
map     <leader>6       :b 6<CR>
map     <leader>7       :b 7<CR>
map     <leader>8       :b 8<CR>
map     <leader>9       :b 9<CR>

" Alt-10 to Alt-19
map     <leader>10      :b 10<CR>
map     <leader>11      :b 11<CR>
map     <leader>12      :b 12<CR>
map     <leader>13      :b 13<CR>
map     <leader>14      :b 14<CR>
map     <leader>15      :b 15<CR>
map     <leader>16      :b 16<CR>
map     <leader>17      :b 17<CR>
map     <leader>18      :b 18<CR>
map     <leader>19      :b 19<CR>

" Alt-20 to Alt-29
map     <leader>20      :b 20<CR>
map     <leader>21      :b 21<CR>
map     <leader>22      :b 22<CR>
map     <leader>23      :b 23<CR>
map     <leader>24      :b 24<CR>
map     <leader>25      :b 25<CR>
map     <leader>26      :b 26<CR>
map     <leader>27      :b 27<CR>
map     <leader>28      :b 28<CR>
map     <leader>29      :b 29<CR>
