" Documentation:
" (experimental) is used for features that I've not certain I will keep
" (untested) needs to be tested

" Ideas:
" Use space as leader
" Make use of inside terminal
" Unite open diff master
" Remap q from record? (I hit it too often)
" Run rubocop / jshint in background
" (expermimental) 'run the last command in the terminal below'
" nnoremap <space> <C-w><C-w><C-p><CR><C-\><C-n><C-w><C-w>
" Ctrl-n completion plug

" Todo:
" Unite.vim is caching used? Do I have newest version? Exclude .gif files?
" git diff master: show line numbers - perhaps make a view to unite?
" visual jump to line
" terminal use of ctrl-move does not work
" Get this under source control
" Avoid swapfile message (in progress)
" -----------------------------------------------------------------------------
" - General
" -----------------------------------------------------------------------------

" Path to python for neovim to use
let g:python3_host_prog = '/usr/local/bin/python3'

" experimental and potentially plugin breaking
map Q <Nop>

" experimental and potentially dangerous
autocmd FileType ruby autocmd BufWritePre <buffer> %s/\s\+$//e

" Saving undo history to an external file (tested: But no sure about what
" happens under source control)
set undofile
set undodir=~/.nvim/undo//

" Allow buffers to be hidden in the background
set hidden

" Don't jump to start of the line when switching buffers (untested)
set nostartofline

" Correct danish characters: æøåÆØÅ
imap <A-'> <A-f>
imap <A-o> <A-x>
imap <A-a> <A-e>
imap <A-"> <A-S-f>
imap <A-S-o> <A-S-x>
imap <A-S-a> <A-S-e>

" Per wrapped line navigration in mulitlines
onoremap j gj
onoremap k gk
onoremap 0 g0
onoremap ^ g^
onoremap $ g$
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap ^ g^
nnoremap $ g$

" Emacs style bindings in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Save backup files in one directory
set backupdir=~/.config/nvim/backup//

" Save swap files in one directory (untested)
" set directory=~/.nvim/swap// "(remove this if setting below is sufficient)

" Do not use swapfiles
set noswapfile

" Use spaces instead of tabs
set expandtab

" Tabs have a length of 2 spaces
set tabstop=2

" Indenting with `>` uses 2 spaces
set shiftwidth=2

" Indent automatically (untested)
set autoindent

" When going to a terminal window, always start in insert mode
autocmd WinEnter term://* startinsert

" Show the name of the current file in titlebar
set title

" Use system clipboard for all commands
set clipboard+=unnamedplus

" Start scrolling where there are 3 lines left
set scrolloff=3

" " Move around splits with <c-hjkl>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
nnoremap <C-h> <C-w>h

" experimental: C-h is buggy in neovim
nnoremap <C-g> <C-w>h

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Show line numbers
set number

" Set the leader key to be ,
let mapleader=","

" Go quickly to previous buffer
map <leader><leader> :b#<CR>

":W means :w
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))

" Add support for cursor
if has('mouse')
  set mouse=a
endif

" Enable the use of esc in terminal mode
tnoremap <Esc> <C-\><C-n>

" Treat .es6 files as .js files
au BufNewFile,BufRead *.es6 set filetype=javascript

" -----------------------------------------------------------------------------
" - Visuals
" -----------------------------------------------------------------------------

" Use 256 colors if terminal supports it
if $TERM == "xterm-256color"
  set t_Co=256
endif

" Show the line to the right.
set colorcolumn=80

" Make the line to the right a nice color.
hi ColorColumn ctermbg=black

"Folded line background color black
hi Folded ctermbg=Black

" No matter the theme, neovim will always be black
" hi Normal ctermbg=16 " experimental

" -----------------------------------------------------------------------------
" - Plugins
" -----------------------------------------------------------------------------
call plug#begin('~/.nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Shougo/neomru.vim'
Plug 'Shougo/vimproc'
Plug 'Shougo/unite.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-projectionist' " experimental
Plug 'vim-ruby/vim-ruby' "Better ctags integration
Plug 'tpope/vim-rails'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rbenv' "Ctag on ruby methods
Plug 'tpope/gem-ctags' "Automatic ctags generation on gem install
Plug 'tommcdo/vim-fugitive-blame-ext'
Plug 'airblade/vim-gitgutter'
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }
Plug 'kopischke/vim-fetch' " experimental
Plug 'mileszs/ack.vim'
Plug 'elixir-lang/vim-elixir' " experimental
Plug 'majutsushi/tagbar' " experimental
Plug 'slim-template/vim-slim'
Plug 'kchmck/vim-coffee-script' "experimental
Plug 'othree/yajs.vim' "experimental
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'StanAngeloff/php.vim'
Plug 'mollerhoj/vim-spectator'

Plug 'dhruvasagar/vim-table-mode' "experimental

" Plug 'dense-analysis/ale'

Plug 'chiedo/vim-case-convert'

Plug 'tweekmonster/django-plus.vim' "makes htmldjango filetype be recognized
Plug 'posva/vim-vue' "syntax highlighting for .vue files

Plug 'ludovicchabant/vim-gutentags' "Manage ctags

Plug 'tpope/vim-surround' "testing

Plug 'udalov/kotlin-vim'

" Typescript """"""""""""""""""""""""""""
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For Denite features
Plug 'Shougo/denite.nvim'

" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

call plug#end()
" -----------------------------------------------------------------------------
" Vim-rspec
" -----------------------------------------------------------------------------

map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = ":!bin/rspec {spec}"

" -----------------------------------------------------------------------------
" NERDTree
" -----------------------------------------------------------------------------

" Use space to open
nmap <space> :NERDTreeToggle<CR>

" use ctrl-space to show current file in NERDTree
let g:CtrlSpaceDefaultMappingKey = "<C-space> "
nmap <C-space> :NERDTreeFind<CR>

" Use a width of 50 by default
let NERDTreeWinSize = 50

" Close NERDTree when a file is opened
let NERDTreeQuitOnOpen = 1

" Close NERDTree with escape
let NERDTreeMapQuit="<ESC>"

" Do not show .pyc files, nor __pycache__ dirs
let NERDTreeIgnore = ['\.pyc$', '__pycache__[[dir]]']

" -----------------------------------------------------------------------------
" Unite (experimental)
" -----------------------------------------------------------------------------

" Allow searching through yank history (experimental)
let g:unite_source_history_yank_enable = 1
nmap <leader>y :<C-u>Unite history/yank<cr>

" browse current directory
" nmap <leader>f :<c-u>Unite file_rec/async:.<cr> (Replaced by fzf)

" Browse rails controllers
nmap <leader>gc :<C-u>Unite file_rec/async:app/controllers<cr>

" Browse rails controllers
nmap <leader>gm :<C-u>Unite file_rec/async:app/models/<cr>

" Browse most recently used files
nmap <leader>m :<C-u>Unite file_mru<cr>

" Open last Unite buffer again (resume)
nmap <leader>r :<C-u>UniteResume<cr>

" Don't jump over first line
let g:unite_enable_auto_select=0

" Stay at the bottom of the window
" With a height of 12
" And start in insert mode
call unite#custom#profile('default', 'context', {
      \ 'winheight': 12,
      \ 'direction': 'botright',
      \ 'start_insert': 1
      \ })

" Use fuzzy matching by default (untested)
call unite#filters#matcher_default#use(['matcher_fuzzy'])

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()

function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)

  " Enable previews with control-p
  imap <buffer> <C-p>   <Plug>(unite_toggle_auto_preview)

  " Close Unite with <esc>
  let b:actually_quit = 0
  setlocal updatetime=3
  au! InsertEnter <buffer> let b:actually_quit = 0
  au! InsertLeave <buffer> let b:actually_quit = 1
  au! CursorHold  <buffer> if exists('b:actually_quit') && b:actually_quit | close | endif
endfunction"

" Use ag for grepping
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts =
  \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

" Search current directory
nmap <leader>a :<C-u>Unite -buffer-name=ag grep:.<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gundo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the undo tree with F5
nnoremap <F5> :MundoToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't update gitgutter automatically (performance)
let g:gitgutter_realtime = 0 " Typing stops
" let g:gitgutter_eager = 0 " Buffer switch

" Diff between this commit and master branch
let g:gitgutter_diff_base = 'master'

""""""""""""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<CR>

let g:tagbar_type_elixir = {
    \ 'ctagstype' : 'elixir',
    \ 'kinds' : [
        \ 'f:functions',
        \ 'functions:functions',
        \ 'c:callbacks',
        \ 'd:delegates',
        \ 'e:exceptions',
        \ 'i:implementations',
        \ 'a:macros',
        \ 'o:operators',
        \ 'm:modules',
        \ 'p:protocols',
        \ 'r:records'
    \ ]
\ }

"""""""""""
" Format XML documents with xmllint (call :XMLlint)
"""""""""""
function! XMLlint()
  silent %!xmllint --encode UTF-8 --format -
endfunction


""""""""""""""""""""""""""""""""""""
"  Show a very nice tabline
""""""""""""""""""""""""""""""""""""
set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label =  bufname(buflist[winnr - 1])
  return fnamemodify(label, ":t")
endfunction
set showtabline=2

"""""""""""""""""""""""""""""""""""""""
"  Rails.vim
"""""""""""""""""""""""""""""""""""""""

" custom command: Eroutes
command! Eroutes Einitializer

" custom command: Egemfile
command! Egemfile edit Gemfile

" custom command: Egemfile
command! Efactories edit spec/factories.rb

""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""

" Overwrite up and down movement
autocmd FileType fzf tnoremap <buffer> <C-j> <Down>
autocmd FileType fzf tnoremap <buffer> <C-k> <Up>

nmap <leader>f :<c-u>FZF<cr>

command! -nargs=1 Gitdiff call fzf#run({'source': 'gitdiff ' . string(<q-args>), 'sink': 'e', 'right': '50%'})

nmap <leader>q :Gitdiff master<cr>



"""""""""""""
" Deocomplete
"""""""""""""
filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

""""""""""
" Command to copy file path and line
""""""""""
map <leader>i :let @*=expand("%") . ':' . line(".")<CR>


"""""
" Ale
"""""

" make htmlhint load config file
let g:ale_html_htmlhint_options = '--format=unix --config .htmlhintrc'

" Specify linters to run
let g:ale_echo_msg_format = '%code: %%s [%linter%]'

highlight ALEWarning ctermbg=DarkGray
highlight ALEError ctermbg=DarkGray
highlight ALEStyleWarning ctermbg=DarkGray
highlight ALEStyleError ctermbg=DarkGray
highlight ALEInfo ctermbg=DarkGray

" let g:ale_html_tidy_args = '-q -e -language e -config .tidyrc'
" let g:ale_linters = { 'eruby': ['htmlhint', 'tidy'], 'html': ['tidy'] }
" let g:ale_linters_explicit = 1 "! remove?

" Python 
let g:ale_linters = {'python': ['flake8']}
let g:ale_fixers = {'python': ['remove_trailing_lines', 'trim_whitespace', 'autopep8']}


"""""
" Utils
"""""

" Show white space characters
set list

" Clear highlighting on Escape
nnoremap <esc> :noh<return><esc>

" Format XML files
command! XmlLint :%!xmllint --format %

"""""
" TEST!!!
"""""
set foldmethod=expr
set foldlevelstart=20
autocmd FileType ruby,eruby,python set foldexpr=getline(v:lnum)=~'^\\s*#'
autocmd FileType javascript set foldexpr=getline(v:lnum)=~'^\\s*/'

" Toggle folding with F2
map <expr> z &foldlevel ? 'zM' :'zR'

set fileformats=unix

" Paste in visual mode without yanking
xnoremap <silent> p p:let @+=@0<CR>

