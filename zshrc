autoload -U colors
colors

setopt prompt_subst
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%{\e[0;33m%}'
zstyle ':vcs_info:*' unstagedstr '%{\e[0;31m%}'

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "%{\e[0;32m%}%u%b%a%{\e[0m%}"

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
PROMPT=$'$(vcs_info_wrapper) %{\e[0;32m%}%~ %{\e[0m%}'
 

# # Colors
# autoload -U colors
# colors
# setopt prompt_subst
# 
# # Prompt
# PROMPT='%~ $'

# Colorize terminal
export TERM='xterm-color'
alias ls='ls -G'
alias ll='ls -lG'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

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
# export DYLD_LIBRARY_PATH="/Library/PostgreSQL/9.2/lib:$DYLD_LIBRARY_PATH"


export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/local/bin:$PATH"
export PATH="/opt/local/sbin:$PATH"
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME.rvm/gems/ruby-2.0.0-p247/bin"

export PKG_CONFIG_PATH="/opt/ImageMagick/lib/pkgconfig/:$PKG_CONFIG_PATH"


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
