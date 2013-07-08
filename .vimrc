
" ---------------- SETTINGS ------------------------


"match ErrorMsg '\%>100v.\+'

" Filetypes
filetype on
filetype plugin indent on


set foldmethod=manual
set foldlevelstart=99
if ! exists('no_plugin_maps')
    au! BufReadPre *.py setlocal foldmethod=indent|setlocal foldnestmax=2|set foldcolumn=2
endif
au BufReadPost *.py call SyntaxOn()
au BufWinEnter,BufRead,BufNewFile *.py set filetype=python
au BufWinEnter,BufRead,BufNewFile *.py\,cover set filetype=python
au BufRead,BufNewFile *.scala set filetype=scala

au BufReadPre,BufWinEnter,BufRead,BufNewFile *\,cover setlocal filetype=python|set syntax=python|hi NotTested ctermbg=52|2match NotTested '^!.*'
"au BufReadPre *\,cover set filetype=python|set syntax=python|hi NotTested ctermbg=52|2match NotTested '^!.*'

set autoindent
set shiftround
set backspace=2
set ruler
set tw=0
set shiftwidth=4
set expandtab
set ts=4
set shortmess=aotT
set backup
set bex=.bak
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
set sessionoptions=buffers,folds,globals,help,localoptions,options,winpos,winsize,resize,unix
set nowrapscan
set titlestring=%t\ (%n)\ %m
set tags=./tags,tags
set splitright
set statusline=[%n]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set listchars=trail:•,tab:>-
set list

set backupdir=~/vim-working/bak//
set dir=~/vim-working/swp//
set undodir=~/vim-working/undo//
set viewdir=~/vim-working/view//

set path=.,./**

" highlight spaces at the end of lines
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted


" ---------------- FUNCTIONS -----------------------


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
    map [[ ?^    \zs{:call histdel("search", -1):let @/ = histget("search", -1)<CR>
    map ]] /^    \zs{:call histdel("search", -1):let @/ = histget("search", -1)<CR>
    map [] ?^    \zs}:call histdel("search", -1):let @/ = histget("search", -1)<CR>
    map ][ /^    \zs}:call histdel("search", -1):let @/ = histget("search", -1)<CR>
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

function! ToggleFoldColumn()
    if &foldcolumn
        set foldcolumn=0
    else
        set foldcolumn=2
    endif
endfunction

function! ToggleIgnorecase()
    if &ignorecase == 0
        set ignorecase
        echo "ignorecase"
    else
        set noignorecase
        echo "no-ignorecase"
    endif
endfunction

"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview
au BufWinEnter,BufRead,BufNewFile *.pp set filetype=puppet

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
    if &paste
        set nopaste
        let g:togglepaste = 0
        echo "paste off"
    else
        set paste
        let g:togglepaste = 1
        echo "paste on"
    endif
endfunction

set nospell
function! ToggleSpell()
    if &spell
        set nospell
        let g:togglespell = 0
        echo "spell off"
    else
        set spell
        let g:togglespell = 1
        echo "spell on"
    endif
endfunction

function! MyHi()
    highlight Title ctermfg=3 cterm=bold
    highlight Identifier ctermfg=6 cterm=none
    highlight statement ctermfg=yellow
    highlight string ctermfg=grey
    highlight PreProc ctermfg=white
    highlight special ctermfg=cyan
    highlight Comment ctermbg=0 ctermfg=6 cterm=none
    highlight String ctermfg=2 cterm=none
    highlight PythonExceptions ctermfg=1 cterm=bold
    highlight pythonFunction ctermfg=4 cterm=none
    highlight Constant ctermfg=1 cterm=bold
    highlight pythonFunction ctermfg=6 cterm=bold
    highlight pythonBuiltin ctermfg=4 cterm=bold
    highlight CursorLine guibg=grey
    highlight CursorColumn guibg=grey
    highlight Folded ctermfg=7 ctermbg=0
    highlight FoldColumn ctermbg=0
endfunction

function! PabloHi()
    highlight Constant              ctermfg=87 cterm=none
    highlight String                ctermfg=47 cterm=none
    highlight Special               ctermfg=46 cterm=none
    highlight Comment               ctermfg=117 cterm=bold
    highlight Statement             ctermfg=227
    highlight PreProc               ctermfg=214 cterm=bold
    highlight Identifier            ctermfg=50 cterm=none
    highlight Todo                  term=none ctermfg=0 ctermbg=3
    highlight shFunction            ctermfg=202 cterm=bold
    highlight Normal                ctermfg=231
    highlight Type                  ctermfg=86
    highlight StatusLine            ctermfg=21 ctermbg=117 cterm=bold
    highlight Folded                ctermfg=230 ctermbg=238
    highlight FoldColumn            ctermbg=238 ctermfg=230
    highlight shDerefSimple         ctermfg=81
    highlight shDerefVar            ctermfg=81
    highlight Visual                term=reverse ctermbg=27
    highlight pythonFunction        ctermfg=123 cterm=bold
    highlight PythonExceptions      ctermfg=9
    highlight pythonBuiltin         ctermfg=159

    highlight ColorColumn           ctermbg=239
    highlight CursorColumn          ctermbg=239
    highlight CursorLine            ctermbg=235

    highlight CommandTSelection     ctermfg=9
    highlight MatchParen            cterm=bold ctermfg=9 ctermbg=0

    highlight link shFunctionKey    Statement
    highlight link shFunction       pythonFunction

endfunction

function! SyntaxOn()
    syntax enable
    if g:colors_name == "pablo"
        call PabloHi()
    else
        call MyHi()
    endif
endfunction

function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
        echo "syntax off"
    else
        call SyntaxOn()
        echo "syntax on"
    endif
endfunction

syntax enable
call MyHi()

function! ToggleQuickfix()
    if exists("g:quickfix_open")
        cclose
        unlet g:quickfix_open
    else
        copen
        let g:quickfix_open = 1
        nnoremap <buffer> q :call ToggleQuickfix()<cr>
    endif
endfunction


function! SetCursorLines(flag)
    if a:flag == 0
        set nocursorline
        set nocursorcolumn
    elseif a:flag == 1
        set cursorline
        set nocursorcolumn
    elseif a:flag == 2
        set nocursorline
        set cursorcolumn
    elseif a:flag == 3
        set cursorline
        set cursorcolumn
    endif
endfunction

function! SetColorColumn(col)
    let cmd='set colorcolumn=' . a:col
    exec cmd
endfunction

" ---------------- COMMANDS ------------------------

" Add s: to all occurances of the current work
command! Srepl execute '%s/\<' . expand('<cword>') . '\>/s:' . expand('<cword>') . '/g'

" Run the current file through markdown and open in chromium
command! Markdown silent execute '!markdown ' . expand('%') . ' > /tmp/' . expand('%:t:r') . '.html' <bar> silent execute '!chromium-browser /tmp/' . expand('%:t:r') . '.html' <bar> redraw!

" Write out the current file as root
command! Wsudo w !sudo tee % >/dev/null

" Split open the current file's corresponding coverage annotated source
command! Coverage execute 'split .cover/' . expand('%:t') . ',cover'


" ---------------- SHORTCUTS -----------------------

let mapleader="\\"

noremap     Q               gq
nnoremap    '               `
nnoremap    `               '

nnoremap    W               :w<CR>
nnoremap    <leader>;       :so %<CR>
nnoremap    <leader>v       :so ~/.vimrc<CR>

nnoremap    <leader>n       :n<CR>
nnoremap    <leader>N       :N<CR>
nnoremap    <leader>h       :call ToggleSyntax()<CR>
nnoremap    <leader>P       :call TogglePaste()<CR>
nnoremap    <leader>z       :call ToggleSpell()<CR>
nnoremap    <leader>i       :call ToggleIgnorecase()<CR>
nnoremap    <leader>c0      :call SetColorColumn(0)<CR>
nnoremap    <leader>c1      :call SetColorColumn(80)<CR>
nnoremap    <leader>c2      :call SetColorColumn(120)<CR>
nnoremap    <leader>C0      :call SetCursorLines(0)<CR>
nnoremap    <leader>C1      :call SetCursorLines(1)<CR>
nnoremap    <leader>C2      :call SetCursorLines(2)<CR>
nnoremap    <leader>C3      :call SetCursorLines(3)<CR>
nnoremap    <leader>q       :silent call ToggleQuickfix()<CR>
nnoremap    zz              :silent call ToggleFoldColumn()<CR>
nnoremap    <leader>[       :call GnuMapUnmap()<CR>
nnoremap    <leader>s       :buffers<CR>
nnoremap    <leader>r       :reg<CR>
nnoremap    <leader>dn      !!date<CR>
nnoremap    <leader>e       :%s/\s\+$//g<CR>
nnoremap    <leader>cd      :cd %:h<CR>:pwd<CR>
nnoremap    <leader>..      :cd ..<CR>:pwd<CR>

" Shows the highlighting in use for the item under the cursor
map         <leader>H       :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" quotes around current word
nnoremap    <leader>"       ve<esc>a"<esc>hbi"<esc>lel<CR>

" Draw line of ----
nnoremap    <leader>l       o75A-0k
nnoremap    <leader>L       o120A-k

" Draw line under current line of text, same length
nnoremap    <leader>k       yyp:.,.s/./-/g<CR>

" Todo list
nnoremap    <leader>to      :e ~/Documents/todo/todo.txt<CR>
nnoremap    <leader>da      :e ~/Documents/todo/daily.txt<CR>

" For tags
nnoremap    <leader>tn      :tn<CR>
nnoremap    <leader>tp      :tp<CR>
nnoremap    <leader>ts      :ts<CR>

" For quickfix list
nnoremap    <leader>cn      :cn<CR>
nnoremap    <leader>cp      :cp<CR>
nnoremap    <leader>cl      :clist<CR>

" For buffers
nnoremap    <leader>bd      :bdel<CR>
nnoremap    <leader>bw      :bwipe<CR>
nnoremap    <leader>bW      :bwipe!<CR>

" Prompt to edit files in same dir as current buffer
nnoremap    <leader>E       :let @"=expand('%:h')<CR>:e "/
nnoremap    <leader>S       :let @"=expand('%:h')<CR>:sp "/
nnoremap    <leader>R       :let @"=expand('%:h')<CR>:r "/

" Map <leader>1...9 to buffers 1...9
for i in range(1, 9)
    exe "nnoremap <leader>" . i . " :b " . i . "<CR>"
endfor

" Map <leader>10...99 to buffers 10...99
for i in range(1, 9)
    for j in range(0, 9)
        exe "nnoremap <leader>" . i . j . " :b " . i . j . "<CR>"
    endfor
endfor



" ---------------- FOR PLUGINS ---------------------

let g:pep8_map = '<F8>'

" Giddy settings
let GiddyTrackingBranch="origin/develop"
let g:giddy_dev=1

" Taglist plguin
map     <leader>tl      :TlistToggle<CR>
let     TlistWinWidth=40
let     Tlist_GainFocus_On_ToggleOpen=1
let     Tlist_Exit_OnlyWindow=1
let     Tlist_Close_On_Select=1

" Pathogen
call pathogen#infect()

" Vimclojure nailgun
let vimclojure#WantNailgun = 1

" CommandT
map         <leader>f       :CommandT<CR>

" Gundo
nnoremap    <leader>u       :GundoToggle<CR>
nnoremap    <leader>U       :GundoToggle<CR>:GundoToggle<CR>

colorscheme pablo
call PabloHi()
