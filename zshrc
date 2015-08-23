export TERM=xterm-256color

setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%{\e[4;33m%}'
zstyle ':vcs_info:*' unstagedstr '%{\e[4;31m%}'
zstyle ':vcs_info:*' enable git

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{\e[4;32m%}%u%b%a%{\e[0m%}"

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del "
  fi
}
PROMPT=$'%{\033[5;43;37m%}>%{\033[0m%} $(vcs_info_wrapper)%{\e[4;32m%}%~ %{\e[0m%}'


# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Use vim as the editor
export EDITOR=vi

# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back.
set -o emacs

# Use C-x C-e to edit the current command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Highlight search results in ack.
export ACK_COLOR_MATCH='red'

# Paths
export PATH=/Developer/NVIDIA/CUDA-5.0/bin:$PATH
export DYLD_LIBRARY_PATH="/Developer/NVIDIA/CUDA-5.0/lib:$DYLD_LIBRARY_PATH" 
export DYLD_FORCE_FLAT_NAMESPACE=1,
# export DYLD_LIBRARY_PATH="/Library/PostgreSQL/9.2/lib:$DYLD_LIBRARY_PATH"
alias serverinit='export DYLD_LIBRARY_PATH="/Library/PostgreSQL/9.2/lib:$DYLD_LIBRARY_PATH"'

export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/local/bin:$PATH"
export PATH="/opt/local/sbin:$PATH"
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/bin/libsvm:$PATH"
export PATH="$HOME/.rvm/bin:$PATH"
export PATH="$HOME.rvm/gems/ruby-1.9.3-p429/bin:$PATH"

# Postgres
export PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

export PKG_CONFIG_PATH="/opt/ImageMagick/lib/pkgconfig/:$PKG_CONFIG_PATH"
export NODE_PATH="/usr/local/lib/node"

# fixes rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" 

# Vim version
alias vim='mvim -v'
alias vi='mvim -v'

# MANUAL READER: Browser

# Correct character encodings, Very important for shell tools!
export LANG=C
export LC_TYPE=C

# Nicer history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

bindkey -M vicmd ' ' clear-screen
# bindkey '^[[Z' reverse-menu-complete

# Define widget w to run command. Like vim save.
function w() {accept-line}
zle -N w

# Define widget w to run command. Like vim save.
function q() {edit-command-line}
zle -N q

setopt correct

bindkey '^[[Z' backward-kill-word
bindkey -M vicmd '?' history-incremental-pattern-search-backward
bindkey -M vicmd '/' history-incremental-search-backward

#
alias del=rmtrash

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

## git completion
autoload -U compinit && compinit

# Autocomplete for 'g' as well
alias g='git'

# Start and end postgres session
alias start_postgres='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias end_postgres='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

### gitopen command to open github repository
alias gitopen="git ls-remote --get-url | sed 's/git@/http:\/\//g' | sed 's/com\:/com\//g'| xargs open"

##Aliases:
alias c="./run"
alias mv="mv -i"
alias cp="cp -i"
alias rm="trash"
alias z="zeus"

#git merge conflicts: Jacobs way
#Use :n to move to next conflict
function editconflicts() { 
  vim +/"<<<<<<<" $( git diff --name-only --diff-filter=U | xargs )
}

alias gitbranchclean='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

# Rake completion
source $HOME/.rake_completion.zsh

# Java, classpath

export CLASSPATH="$HOME/bin/junit-4.12-beta-3.jar:$CLASSPATH"
export CLASSPATH="$HOME/bin/hamcrest-core-1.3.jar:$CLASSPATH"
export CLASSPATH="$HOME/ku/sis:$CLASSPATH"

# Add rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Need ulimitted file edit permissions for `browserify`. See:
# https://github.com/jsdf/coffee-reactify/issues/3
ulimit -n 2560
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _npm_completion npm
elif type compdef &>/dev/null; then
  _npm_completion() {
    local si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 npm completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef _npm_completion npm
elif type compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###
