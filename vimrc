" Jens Dahl Mollerhojs .vimrc file
" Mostly copied from Gary Bernhardt.

call pathogen#runtime_append_all_bundles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=50 "79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
set textwidth=0
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list,full
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" Fix slow O inserts
":set timeout timeoutlen=1000 ttimeoutlen=100
" Show line numbers
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,python set ai sw=2 sts=2 et

  autocmd! BufRead,BufNewFile *.sass setfiletype sass 

  autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
  autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;

  " Don't syntax highlight markdown because it's often wrong
  autocmd! FileType mkd setlocal syn=off

  "JENS
  autocmd FileType text setlocal dict+=/usr/share/dict/words

augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable
set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Can't be bothered to understand ESC vs <c-c> in insert mode
imap <c-c> <esc>
" Close all other windows,k open a vertical split, and open this file's test
" alternate in it.
nnoremap <leader>s <c-w>o <c-w>v <c-w>w :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
":map <leader>p :PromoteToLet<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>t :call RunTestFile()<cr>
"map <leader>T :call RunNearestTest()<cr>
"map <leader>a :call RunTests('')<cr>
"map <leader>c :w\|:!script/features<cr>
"map <leader>w :w\|:!script/features --profile wip<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Md5 COMMAND
" Show the MD5 of the current buffer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! -range Md5 :echo system('echo '.shellescape(join(getline(<line1>, <line2>), '\n')) . '| md5')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
command! OpenChangedFiles :call OpenChangedFiles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" InsertTime COMMAND
" Insert the current time
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! InsertTime :normal a<c-r>=strftime('%F %H:%M:%S.0 %z')<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Jens, my personal touch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let NERDTreeQuitOnOpen = 1

" Add support for mouse
if has('mouse')
  set mouse=a
endif

"Remove ugly GUI from MacVim
if has("gui_running")
    set guioptions=egmrt
endif

"Silently kill swapfiles
"silent execute '!rm ~/.vim-tmp-to-die/*'
silent execute '!mv ~/.vim-tmp/* ~/.vim-tmp-to-die/ 2>/dev/null'

" Remove startup message
set shortmess+=I

"Good looking cursorline
hi CursorLine term=bold ctermbg=236 cterm=bold guibg=Grey40

" Remap VIM 0 to first non-blank character
map 0 ^

" Wrapping lines are treated as breaking lines
map j gj
map k gk

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set clipboard=unnamedplus
" nnoremap yy yy"+yy
" vnoremap y ygv"+y
"
" Clipboard
map <leader>y "+yy
map <leader>p "+p

" NERDTree
" map <leader>f :NERDTreeToggle<CR>

" New name
map <leader>n :call RenameFile()<cr>

" Open from jumplist
" map <leader>j :CommandTJump<cr>

" CtrlP
"map <Space> :CtrlPBuffer<cr>
"nmap <C-@> :CtrlP<cr>

" Toggle spell checking
map <leader>s :setlocal spell!<cr>

"Run command
" map <leader>a :VimuxPromptCommand<CR>

"Run last command
" map <leader>r :VimuxRunLastCommand<CR>

" Interrupt any command running in the runner pane map
" map <leader>c :VimuxInterruptRunner<CR>

" Prevous buffer 
map <leader>2 :b#<CR>

" 2x Leader = previous file
nnoremap <leader><leader> <c-^>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Command T
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:CommandTCancelMap = ['']
let g:CommandTMatchWindowReverse=1

" CommandT, space for buffer
map <Space> :CommandTFlush<cr>\|:CommandTBuffer<cr>

set wildignore+=*.o,*.obj,*.png,*.lvl,*.svg,*.ttf,*jpg,*wav,*zip,*.mp3,public/**,tmp/**,log/**

map <leader>gR :call ShowRoutes()<cr>
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>ga :CommandTFlush<cr>\|:CommandT app/assets<cr>
map <leader>gj :CommandTFlush<cr>\|:CommandT app/assets/javascripts<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT spec<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gS :topleft 100 :split db/structure.sql<cr>
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
map <leader>F :CommandTFlush<cr>\|:CommandT %%<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""
"Vimux configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vertical indentation
"let g:VimuxOrientation = "v"

" Use nearest pane
"let VimuxUseNearestPane = 1

""""""""""""
" More
""""""""
set notimeout
set ttimeout

"Remove highlighting for long lines (it is slow)
set synmaxcol=140

" eval clojure code
" map <C-CR> :%Eval<CR>

"Python check syntax
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

" Execute a selection of code (very cool!)
" Use VISUAL to select a range and then hit ctrl-h to execute it.
python << EOL
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL

vmap <CR> :py EvaluateCurrentRange()<CR>

"line width color test
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"include library in tab-completion.
set complete=.,w,b,u,t,i,k

"Danish characters
let g:danish = 0
function! DanishModeToggle()
  if g:danish
    let g:danish = 0
    imap a a
    imap o o
    imap ' '
    imap A A
    imap O O
    imap " "
  else
    let g:danish = 1
    imap a å
    imap o ø
    imap ' æ
    imap A Å
    imap O Ø
    imap " Æ
  endif
endfunction

nnoremap <leader>d :call DanishModeToggle()<cr>

"disable caching in CtrlPA 
"let g:ctrlp_use_caching = 0
"always open files in new buffers
"let g:ctrlp_switch_buffer = 0
"Ctrlp use current shell's directory, not current file's directory
let g:ctrlp_working_path_mode = 0
"use ag for speed
"let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'

":W means :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

"TEST: text wrap.
"Annoying for anything but .txt files....
":set formatoptions+=aw

"TEST: CtrlP deletes buffers on command
"let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
    nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
    let line = getline('.')
    let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
        \ : fnamemodify(line[2:], ':p')
    exec "bd" bufid
    exec "norm \<F5>"
endfunc

command! SudoW w !sudo tee % > /dev/null

"Ack
map <Leader>C :Ack! <cword><CR>

"Use Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

"Do not use the same terminal session as vim to run system commands: (for Ack)
"set t_ti= t_te=
"set shellpipe=2>&1>

"Remove the file with command:
" function! Remove()
"   call delete(expand('%')) | bdelete!
" endfunction

nnoremap <leader>d :call DanishModeToggle()<cr>

"Don't jump to start of the line when switching buffers
set nostartofline

"Translate to russian
let g:langpair="ru" 

"Visual translate with (mark and press T)
let g:vtranslate="T" 


"Unmap annoying shift K
map <S-K> <Nop>

"haskell (must be run 'after')
"hi link hsNiceOperator Operator
"hi! link Conceal Operator
"setlocal conceallevel=2
"syntax match hsNiceOperator "\\" conceal cchar=λ

"cscope load cscope.out file
if has("cscope")
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
endif

"cscope find all uses of a function
set cscopequickfix=s-,c-,d-,i-,t-,e-

function! FindAllCallsTo( arg )
    execute 'cscope find c ' . a:arg
    execute 'cope'
endfunction 

command! -nargs=1 CallsTo call FindAllCallsTo( '<args>' )

