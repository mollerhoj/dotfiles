" Jens Dahl Mollerhojs .vimrc file

"Pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Vundle 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off " (vundle required)

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" My vundle plugins
Plugin 'thoughtbot/vim-rspec'

Plugin 'pangloss/vim-javascript'
" ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

call vundle#end()            " (vundle required)
filetype plugin indent on    " (vundle required)

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " BASIC EDITING CONFIGURATION
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
" " allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
			
" Use spaces instead of tabs
set expandtab

" Tabs have a length of 2 spaces
set tabstop=2

" Indenting with `>` uses 2 spaces
set shiftwidth=2

" Indent automatically
set autoindent

" Keep showing the statusline (do not make it disapear)
set laststatus=2
" Show result of search live when typing
set incsearch
" Highlight searches
set hlsearch
" " make searches case-sensitive only if they contain upper-case characters
" set ignorecase smartcase
" " highlight current line
" set cursorline
" set cmdheight=2
" set switchbuf=useopen
" set numberwidth=5
" set showtabline=0
" set winwidth=50 "79
" " This makes RVM work inside Vim. I have no idea why.
" set shell=bash
" " keep more context when scrolling off the end of a buffer
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
" " Enable file type detection.
" set textwidth=0
" " Use the default filetype settings, so that mail gets 'tw' set to 72,
" " 'cindent' is on in C files, etc.
" " Also load indent files, to automatically do language-dependent indenting.
" filetype plugin indent on
" " use emacs-style tab completion when selecting files, etc
set wildmode=longest,list,full
" " make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","
" " Fix slow O inserts
" ":set timeout timeoutlen=1000 ttimeoutlen=100
" " Show line numbers
set number

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" augroup vimrcEx
"   " Clear all autocmds in the group
"   autocmd!
"   autocmd FileType text setlocal textwidth=78
"   " Jump to last cursor position unless it's invalid or in an event handler
"   autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal g`\"" |
"     \ endif
" 
"   "for ruby, autoindent with two spaces, always expand tabs
"   autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber,python set ai sw=2 sts=2 et
" 
"   autocmd! BufRead,BufNewFile *.sass setfiletype sass 
" 
"   autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:&gt;
"   autocmd BufRead *.markdown  set ai formatoptions=tcroqn2 comments=n:&gt;
" 
"   " Don't syntax highlight markdown because it's often wrong
"   autocmd! FileType mkd setlocal syn=off
" 
"   "JENS
"   autocmd FileType text setlocal dict+=/usr/share/dict/words
" 
" augroup END

autocmd! BufRead,BufNewFile *.md set syntax=markdown

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " STATUS LINE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
:set statusline+=%{fugitive#statusline()}
:set statusline+=\ %P
" 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " MISC KEY MAPS
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" " Can't be bothered to understand ESC vs <c-c> in insert mode
" imap <c-c> <esc>
" 
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " RENAME CURRENT FILE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>n :call RenameFile()<cr>

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
" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
command! OpenChangedFiles :call OpenChangedFiles()

function! OpenChangedFiles()
  only " Close all windows, unless they're modified
let status = system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec "edit " . filenames[0]
  for filename in filenames[1:]
    exec "sp " . filename
  endfor
endfunction
 
" Add support for cursor
if has('mouse')
  set mouse=a
endif

" Remove startup message
set shortmess+=I
" "Good looking cursorline
" hi CursorLine term=bold ctermbg=236 cterm=bold guibg=Grey40
" 
" Remap VIM 0 to first non-blank character
map 0 ^
 
" Wrapping lines are treated as breaking lines
map j gj
map k gk

" Clipboard settings
set clipboard=unnamedplus
nnoremap yy yy"+yy 
vnoremap y ygv"+y
map <leader>y "+yy
map <leader>p "+p

" NERDTree
nmap <space> :NERDTreeToggle<CR>
nmap <leader>w :NERDTreeFind<CR>
let NERDTreeWinSize = 50
let NERDTreeQuitOnOpen = 1

" Open from jumplist
map <leader>j :CommandTJump<cr>

" Open from most recently used
map <leader>m :CommandTMRU<cr>
 
" Prevous buffer 
map <leader><leader> :b#<CR>
 
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Command T
" """""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Let esc cancel CommandT
let g:CommandTCancelMap = ['']
" Show files in reverse order
let g:CommandTMatchWindowReverse=1
" "let g:CommandTQuickfixMap = ['C-r']
 
" Do not care for files that are not source code.
set wildignore+=*.o,*.obj,*.png,*.lvl,*.svg,*.ttf,*jpg,*wav,*zip,*.mp3,tmp/**,log/**,node_modules
 
" rails custom routes
map <leader>gb :CommandTFlush<cr>\|:CommandTBuffer <cr>
map <leader>gr :call ShowRoutes()<cr>
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

" set notimeout
" set ttimeout
" 
" "Remove highlighting for long lines (it is slow)
" set synmaxcol=140
" 
" Show the red line to the right.
set colorcolumn=80
" 
" "include library in tab-completion.
" set complete=.,w,b,u,t,i,k
" 

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

"use ag for speed
"let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'

":W means :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Use `SudoW` to sudo write!
command! SudoW w !sudo tee % > /dev/null
 
" Ack
map <leader>C :Ack! <cword><CR>

"Use Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

"Don't jump to start of the line when switching buffers
set nostartofline

" nmap annoying shift K
map <S-K> <Nop>

" "Load cscope if possible
" cscope load cscope.out file
" if has("cscope")
"   " add any database in current directory
"   if filereadable("cscope.out")
"       cs add cscope.out
"   endif
" endif
"  
" "cscope find all uses of a function
" set cscopequickfix=s-,c-,d-,i-,t-,e-
" function! FindAllCallsTo( arg )
"     execute 'cscope find c ' . a:arg
"     execute 'cope'
" endfunction 
" command! -nargs=1 CallsTo call FindAllCallsTo( '<args>' )

"Tagbar
nmap <F3> :TagbarToggle<CR>
 
"Gundo
nnoremap <F5> :GundoToggle<CR>

" colors
colorscheme solarized

if has("gui_running")
    set guioptions=egmrt
		colorscheme github
else

endif

hi MatchParen cterm=none ctermbg=darkgray ctermfg=white

" The target of the :Tube command is iterm.
let g:tube_terminal = "iterm"
 
" Easytags update async. Easytags or vim-misc seems to have broken git commit.
let g:easytags_async = 1

" "TEST: text wrap, for txt files:
" ":set formatoptions+=aw
 
" "SuperTab
" let g:SuperTabDefaultCompletionType = "<c-n>"
" 
" " Neocompl: 
" 
" "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" " Disable AutoComplPop.
" let g:acp_enableAtStartup = 0
" " Use neocomplcache.
" let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
" let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
" let g:neocomplcache_min_syntax_length = 3
" let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" 
" set shellpipe=>
"
" Use old regexp engine for faster syntax highlighting
set re=1

" Set gutter color so gitgutter becomes visible
highlight clear SignColumn 

" RSpec.vim mappings
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

" Rspec command
" let g:rspec_command = "!bin/rspec --no-color {spec}"
let g:rspec_command = "!bin/rspec {spec}"

" backup to ~/.tmp 
set backup 
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set backupskip=/tmp/*,/private/tmp/* 
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp 
set writebackup

" Style .es6 as javascript
autocmd BufRead,BufNewFile *.es6 setfiletype javascript


