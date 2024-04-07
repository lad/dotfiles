
" ---------------- SETTINGS ------------------------

set t_ti= t_te=
set nostartofline
set modeline
set modelines=1

"match ErrorMsg '\%>100v.\+'

" Pathogen
" call pathogen#infect()
syntax on
syntax sync fromstart
filetype on
filetype plugin indent on

set t_Co=256

set foldmethod=manual
set foldlevelstart=99
au BufRead,BufNewFile Jenkinsfile set filetype=groovy
au BufRead,BufNewFile *.mdb       set filetype=mdb

au Filetype mdb source ~/.vim/scripts/mdb.vim


"au BufReadPost *.py call SyntaxOn()
"au BufWinEnter,BufRead,BufNewFile *.py set filetype=python
"au BufWinEnter,BufRead,BufNewFile *.py\,cover set filetype=python
"au BufRead,BufNewFile *.scala set filetype=scala
"au BufRead,BufNewFile *.ru set filetype=ruby
"au BufReadPre,BufWinEnter,BufRead,BufNewFile *\,cover setlocal filetype=python|set syntax=python|hi NotTested ctermbg=52|2match NotTested '^!.*'
"au BufReadPre *\,cover set filetype=python|set syntax=python|hi NotTested ctermbg=52|2match NotTested '^!.*'

autocmd FileType go setlocal noexpandtab shiftwidth=8 tabstop=8 softtabstop=8 nolist
autocmd FileType go call ColorColumnOff()


set autoindent
set shiftround
set backspace=2
set shiftwidth=2
set ruler
set tw=0
set expandtab
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
set nowrapscan
set titlestring=%t\ (%n)\ %m
set splitright
set statusline=[%n]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
"set statusline=[%n]\ %<%f\ %h%m%r%=
set laststatus=2
set listchars=trail:•,tab:>-
set showbreak=↪\   " Character to preceed line wraps
set iskeyword=@,48-57,_,192-255
"set list
"set sessionoptions=buffers,folds,globals,help,localoptions,options,winpos,winsize,resize,unix

set backupdir=~/vim-working/bak//
set dir=~/vim-working/swp//
set undodir=~/vim-working/undo//
set viewdir=~/vim-working/view//
set path=.,./**

" highlight spaces at the end of lines
highlight RedundantSpaces term=standout ctermbg=red guibg=red
match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted

" ---------------- FUNCTIONS -----------------------

"set foldtext=MyFoldText()
function! MyFoldText()
  let line = getline(v:foldstart)
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

function! ToggleShowBreak()
    if &showbreak != ''
        set showbreak=
        echo "no showbreak"
    else
        set showbreak=↪\   " Character to preceed line wraps
        echo "showbreak"
    endif
endfunction

function! ToggleLineBreak()
    if &linebreak
        set nolinebreak
        echo "no linebreak"
    else
        set linebreak
        echo "linebreak"
    endif
endfunction

function! ToggleList()
    if &list == 0
        set list
        echo "list"
    else
        set nolist
        echo "nolist"
    endif
endfunction

function! ToggleColorColumn()
    if exists("g:cciff")
        unlet g:cciff
        " Unset mark
        call clearmatches()
        echo "ColorColumn: off"
    else
        let g:cciff = 1
        " Sets a mark at column 81 iff text is present
        call matchadd('ColorColumn', '\%82v')
        call matchadd('ColorColumn', '\%101v')
        echo "ColorColumn: on"
    endif
endfunction

function! ColorColumnOff()
  let g:cciff = 1
  call ToggleColorColumn()
endfunction

"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview
"au BufWinEnter,BufRead,BufNewFile *.pp set filetype=puppet

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
"au BufWinLeave * silent! mkview
"au BufWinEnter * silent! loadview

set nopaste
function! TogglePaste()
    if &paste
        set nopaste
        echo "paste off"
    else
        set paste
        echo "paste on"
    endif
endfunction

set nospell
function! ToggleSpell()
    if &spell
        set nospell
        echo "spell off"
    else
        set spell
        echo "spell on"
    endif
endfunction

"   function! MyHi()
"       highlight Title ctermfg=3 cterm=bold
"       highlight Identifier ctermfg=6 cterm=none
"       highlight statement ctermfg=yellow
"       highlight string ctermfg=grey
"       highlight PreProc ctermfg=white
"       highlight special ctermfg=cyan
"       highlight Comment ctermbg=0 ctermfg=6 cterm=none
"       highlight String ctermfg=2 cterm=none
"       highlight PythonExceptions ctermfg=1 cterm=bold
"       highlight pythonFunction ctermfg=4 cterm=none
        highlight Constant ctermfg=196 cterm=none
"       highlight pythonFunction ctermfg=6 cterm=bold
"       highlight pythonBuiltin ctermfg=4 cterm=bold
"       highlight CursorLine guibg=grey
"       highlight CursorColumn guibg=grey
"       highlight Folded ctermfg=7 ctermbg=0
"       highlight FoldColumn ctermbg=0
"
"       highlight link rubySymbol NONE
"       highlight! rubySymbol ctermfg=33
"   endfunction
"
function! PabloHi()
    hi rubyLocalVariableOrMethod ctermfg=1
    highlight Constant              ctermfg=87 cterm=none
    highlight String                ctermfg=47 cterm=none
    highlight Special               ctermfg=46 cterm=none guifg=#00ffff
    highlight Comment               ctermfg=117 cterm=bold guifg=#898989
    highlight Statement             ctermfg=227
    highlight PreProc               ctermfg=214 cterm=bold
    highlight Identifier            ctermfg=50 cterm=none
    highlight Todo                  ctermfg=11 ctermbg=1 term=none
    highlight shFunction            ctermfg=202 cterm=bold
    "highlight Normal                ctermfg=231
    "highlight Normal                ctermfg=41 guifg=#00af5f
    highlight Normal                ctermfg=41 guifg=#00cc1f
    highlight Type                  ctermfg=86
    highlight StatusLine            ctermfg=21 ctermbg=117 cterm=bold
    highlight Folded                guibg=#a0a0a0 guifg=Blue
    " highlight Folded                ctermfg=230 ctermbg=238 guifg=230 guibg=238 term=standout
    " Folded         xxx term=standout ctermfg=230 ctermbg=238 guifg=Cyan guibg=DarkGrey

    highlight FoldColumn            ctermbg=238 ctermfg=230
    highlight shDerefSimple         ctermfg=81
    highlight shDerefVar            ctermfg=81
    "highlight Visual                term=reverse ctermbg=27
    highlight Visual                guibg=Gray guifg=Blue
    highlight pythonFunction        ctermfg=123 cterm=bold
    highlight PythonExceptions      ctermfg=9
    highlight pythonBuiltin         ctermfg=159

    highlight ColorColumn           ctermbg=9
    highlight CursorColumn          ctermbg=9
    highlight CursorLine            ctermbg=235

    "highlight CommandTSelection     ctermfg=9
    highlight MatchParen            cterm=bold ctermfg=9 ctermbg=0

    highlight link shFunctionKey    Statement
    highlight link shFunction       pythonFunction

    highlight link rubySymbol       NONE
    highlight! rubySymbol           ctermfg=44

    "maybe
    highlight String               ctermfg=187
    highlight SpellBad             gui=underline,bold guifg=White
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

"syntax enable
"call MyHi()

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

" Add s: to all occurances of the current word
command! Srepl execute '%s/\<' . expand('<cword>') . '\>/s:' . expand('<cword>') . '/g'

" Run the current file through markdown and open in chromium
" command! Markdown silent execute '!markdown ' . expand('%') . ' > /tmp/' . expand('%:t:r') . '.html' <bar> silent execute '!chromium-browser /tmp/' . expand('%:t:r') . '.html' <bar> redraw!
command! Markdown silent execute '!~/bin/Markdown.pl ' . expand('%') . ' > /tmp/' . expand('%:t:r') . '.html' <bar> silent execute '!open -a Google\ Chrome /tmp/' . expand('%:t:r') . '.html' <bar> redraw!

" Write out the current file as root
command! Wsudo w !sudo tee % >/dev/null

command! Chrome silent execute '!open -a Google\ Chrome ' . expand('<cfile>') <bar> redraw!
command! Open silent execute '!open ' . expand('<cfile>') <bar> redraw!

" Split open the current file's corresponding coverage annotated source
command! Coverage execute 'split .cover/' . expand('%:t') . ',cover'

command! Rubygrep execute 'vimgrep /' . expand('<cword>') . '/ lib/**/*.rb'

"command! RubocopThis execute '!rubocop -c etc/rubocop.yml ' . expand('%')
"command! RubocopAll execute '!rubocop -c etc/rubocop.yml .'
"command! RubocopLib execute '!rubocop -c etc/rubocop.yml ' . expand('%:p:h') . '/lib'

function! RubocopThis() abort
  let l:cmd = 'rubocop -c etc/rubocop.yml ' . expand('%') . ' >| /tmp/e ; cat /tmp/e'
  echo system(l:cmd)
  cfile /tmp/e
endfunction

function! RubocopAll() abort
  let l:cmd = 'rubocop -c etc/rubocop.yml . >| /tmp/e ; cat /tmp/e'
  echo system(l:cmd)
  cfile /tmp/e
endfunction

function! RubocopLib() abort
  let l:cmd = 'rubocop -c etc/rubocop.yml lib >| /tmp/e'
  call system('cd $(git rev-parse --show-toplevel) && ' . l:cmd)
  cfile /tmp/e
endfunction


" ---------------- SHORTCUTS -----------------------

let mapleader="\\"

noremap     Q               gq
nnoremap    '               `
nnoremap    `               '

nnoremap    W               :w<CR>
nnoremap    <leader>;       :so %<CR>
nnoremap    <leader>v       :so ~/.vimrc<CR>

nnoremap    <leader>d       !!date '+\%a \%Y-\%m-\%d \%H:\%M'<CR>
nnoremap    <leader>n       :n<CR>
nnoremap    <leader>N       :N<CR>
nnoremap    <leader>h       :call ToggleSyntax()<CR>
nnoremap    <leader>P       :call TogglePaste()<CR>
nnoremap    <leader>z       :call ToggleSpell()<CR>
nnoremap    <leader>i       :call ToggleIgnorecase()<CR>
nnoremap    <leader>B       :call ToggleShowBreak()<CR>
nnoremap    <leader>L       :call ToggleLineBreak()<CR>
nnoremap    <leader>x       :call ToggleList()<CR>
nnoremap    <leader>c0      :call SetColorColumn(0)<CR>
nnoremap    <leader>c1      :call SetColorColumn(80)<CR>
nnoremap    <leader>c2      :call SetColorColumn(100)<CR>
nnoremap    <leader>C0      :call SetCursorLines(0)<CR>
nnoremap    <leader>C1      :call SetCursorLines(1)<CR>
nnoremap    <leader>C2      :call SetCursorLines(2)<CR>
nnoremap    <leader>C3      :call SetCursorLines(3)<CR>
nnoremap    <leader>q       :silent call ToggleQuickfix()<CR>
nnoremap    zz              :silent call ToggleFoldColumn()<CR>
nnoremap    <leader>s       :buffers<CR>
nnoremap    <leader>r       :reg<CR>
nnoremap    <leader>e       :%s/\s\+$//g<CR>
nnoremap    <leader>cd      :cd %:h<CR>:pwd<CR>
nnoremap    <leader>..      :cd ..<CR>:pwd<CR>
nnoremap    <leader>cc      :call ToggleColorColumn()<CR>
nnoremap    <leader>O       :browse oldfiles<CR>
" nnoremap    <leader>o       O<ESC>
nnoremap    <leader>w       :set nowrap<CR>
nnoremap    <leader>W       :set wrap<CR>
nnoremap    <leader>p       Oimport pdb; pdb.set_trace()<ESC>
nnoremap    <leader>t0      :set tw=0<CR>
nnoremap    <leader>t8      :set tw=80<CR>
nnoremap    <leader>t1      :set tw=110<CR>
nnoremap    <leader>t2      :set tw=120<CR>
nnoremap    <leader>m       :execute 'edit ' . expand('$HOME') . '/medical/health.txt'<CR>
nnoremap    <leader>M       :execute 'edit ' . expand('$HOME') . '/medical/weight.txt'<CR>
nnoremap    <leader>,       :execute 'edit ' . expand('$HOME') . '/noise.txt'<CR>
nnoremap    <leader>a       :execute 'edit ' . expand('$HOME') . '/Anatomy/anatomy-notes.txt'<CR>
nnoremap    <leader>o       :execute 'edit ' . expand('$HOME') . '/Anatomy/osteology-notes.txt'<CR>



" Shows the highlighting in use for the item under the cursor
map         <leader>H       :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" quotes around current word
nnoremap    <leader>"       :execute 's/\(\<' . expand('<cword>') . '\>\)/"\1\"/'<CR>
nnoremap    <leader>'       :execute 's/\(\<' . expand('<cword>') . '\>\)/' . "'"  . '\1'  . "'"  . '/'<CR>


" Draw line of ----
nnoremap    <leader>l       o75A-0k

" Draw line under current line of text, same length
nnoremap    <leader>k       yyp:.,.s/./-/g<CR>

" For tags
function! Ctags() abort
  let l:cmd = 'ctags -R --exclude=vendor --exclude=build --exclude=tmp .'
  let l:output = system('cd $(git rev-parse --show-toplevel) && ' . l:cmd)
  if !v:shell_error
    echo "Done"
  else
    if strlen(l:output)
      for l:line in split(l:output, '\n')
        echo l:line
      endfor
    endif
  endif
endfunction

command!    Ctags           call Ctags()
map         <leader>tt      :Ctags<CR>
nnoremap    <leader>tn      :tn<CR>
nnoremap    <leader>tp      :tp<CR>
nnoremap    <leader>ts      :ts<CR>
" nnoremap    <leader>g       :Rubygrep<CR>

" For tags
nnoremap    <leader>tn      :tl<CR>
nnoremap    <leader>tl      :tl<CR>
nnoremap    <leader>ts      :ts<CR>

" For quickfix list
nnoremap    <leader>cn      :cn<CR>
nnoremap    <leader>cp      :cp<CR>
nnoremap    <leader>cl      :clist<CR>

" For buffers
nnoremap    <leader>bd      :bdel<CR>

" Prompt to edit files in same dir as current buffer
nnoremap    <leader>E       :let @x=expand('%:h')<CR>:e x/
nnoremap    <leader>S       :let @x=expand('%:h')<CR>:sp x/

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


function! RunJira(cmd) abort
  if strlen(a:cmd) == 0
    let l:cmd = input('> ')
  else
    let l:cmd = a:cmd
  endif

  if strlen(l:cmd) != 0
    echo "working..."
    let l:output = systemlist("jira " . l:cmd)
    if v:shell_error
      let l:err = "Error running jira command: " . join(l:output, "\n")
      echo l:err
      return
    endif

    execute 'new ' . l:cmd
    setlocal buftype=nofile bufhidden=hide nobuflisted noswapfile
    call append(line('$'), l:output)
  endif
endfunction

function! JiraView() abort
endfunction

command!    JiraView   call RunJira("view " . expand('<cWORD>'))
map <leader>j :JiraView<CR>

command!    RunJira   call RunJira("")
map <leader>J :RunJira<CR>


" ---------------- FOR PLUGINS ---------------------

let g:pep8_map = '<F8>'

" Giddy settings
let GiddyTrackingBranch="origin/master"
let g:giddy_dev=1


colorscheme pablo
call PabloHi()
