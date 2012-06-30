" Basic settings
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

set path=.,test/**

filetype on
filetype plugin indent on

" highlight spaces at the end of lines
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

" Misc
noremap Q gq
nnoremap ' `
nnoremap ` '

function! ToggleStyle()
    " First time, default to ANSI
    if !exists("b:style")
        let b:style = "ANSI"
        " Set ANSI style indents
        set cinoptions=>4,(0,w1,W1s
        return
    endif

    " If ANSI style, switch to GNU
    if b:style == "ANSI"
        " Remap these to match GNU style brackets
        map [[ ?^    \zs{:call histdel("search", -1):let @/ = histget("search", -1)
        map ]] /^    \zs{:call histdel("search", -1):let @/ = histget("search", -1)
        map [] ?^    \zs}:call histdel("search", -1):let @/ = histget("search", -1)
        map ][ /^    \zs}:call histdel("search", -1):let @/ = histget("search", -1)

        " Set GNU style indents
        set cinoptions=>4,f1s,{1s,^-2,:1s,=1s,g0,h2,p5,t0,+2,(0,u0,w1,m1,W1s
        let b:style = "GNU"
        echo "Gnu Style"
    else
        " If GNU style, switch to ANSI
        unmap [[
        unmap ]]
        unmap []
        unmap ][

        " Set ANSI style indents
        set cinoptions=>4,(0,w1,W1s
        let b:style = "ANSI"
        echo "ANSI Style"
    endif
endfunction

call ToggleStyle()

set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return sub
endfunction

au BufWinLeave *.c,*.cpp,*.h,*.java,*.py,*.pp silent! mkview
au BufWinEnter *.c,*.cpp,*.h,*.java,*.py,*.pp silent! loadview

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

" Highlighting on by default (see call HighlightOn)

function! ToggleHighlight()
    if !exists("b:togglehighlight")
        let b:togglehighlight = 0
    endif

    if b:togglehighlight == 1
        call HighlightOn()
        let b:togglehighlight = 0
        echo "syntax on"
    else
        syntax off
        let b:togglehighlight = 1
        echo "syntax off"
    endif
endfunction

function! HighlightOn()
    syntax on
    hi statement ctermfg=yellow
    hi string ctermfg=grey
    hi PreProc ctermfg=white
    hi special ctermfg=cyan
    hi comment ctermfg=blue guifg=darkblue
    let c_syntax_for_h=1
endfunction

call HighlightOn()

" colorscheme evening

map     W           :w

let mapleader="\\"

" Misc shortcuts
map     <leader>h   :call ToggleHighlight()
map     <leader>p   :call TogglePaste()
map     <leader>z   :call ToggleSpell()
map     <leader>[   :call ToggleStyle()
map     <leader>s   :buffers

" Grep shortcuts
"map     \g      :grep "<cword>" *.py

" Draw line of ----
map     <leader>l   o75A-0k
map     <leader>L   o120A-k
" Draw line under current line of text, same length
map     <leader>k   yyp:.,.s/./-/g
map     <leader>r   :reg
map     <leader>e   :%s/\s\+$//g

" tags
map     <leader>tn  :tn
map     <leader>tp  :tp
map     <leader>ts  :ts

" make errors
map     <leader>cn  :cn
map     <leader>cp  :cp
map     <leader>cl  :cl

" PEP8 plugin shortcut
let     g:pep8_map="<leader>P"

" Shortcuts for switching buffers

" Alt-1 to Alt-9
map     <leader>1   :b 1
map     <leader>2   :b 2
map     <leader>3   :b 3
map     <leader>4   :b 4
map     <leader>5   :b 5
map     <leader>6   :b 6
map     <leader>7   :b 7
map     <leader>8   :b 8
map     <leader>9   :b 9

" Alt-10 to Alt-19
map     <leader>10  :b 10
map     <leader>11  :b 11
map     <leader>12  :b 12
map     <leader>13  :b 13
map     <leader>14  :b 14
map     <leader>15  :b 15
map     <leader>16  :b 16
map     <leader>17  :b 17
map     <leader>18  :b 18
map     <leader>19  :b 19

" Alt-20 to Alt-29
map     <leader>20  :b 20
map     <leader>21  :b 21
map     <leader>22  :b 22
map     <leader>23  :b 23
map     <leader>24  :b 24
map     <leader>25  :b 25
map     <leader>26  :b 26
map     <leader>27  :b 27
map     <leader>28  :b 28
map     <leader>29  :b 29
