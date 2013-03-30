source /usr/local/git/contrib/completion/git-completion.bash
source /usr/local/git/contrib/completion/git-prompt.sh

# To make sed work.
export LANG=C

alias go='git checkout ' 
alias ls='ls -p'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'

#To remove font-changes in iterm2, open terminal and run:
#defaults write com.googlecode.iterm2 PinchToChangeFontSizeDisabled -bool true

shopt -s histappend #Add to history without deleting

#PROMT_COMMAND is executed every time a new pane is opened.
export PROMPT_COMMAND="history -a; history -n"

export HISTCONTROL=ignoreboth:erasedups #Might remove dublicates.

HISTFILESIZE=1000000000
HISTSIZE=1000000

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export PATH="/Developer/NVIDIA/CUDA-5.0/bin:$PATH"
export DYLD_LIBRARY_PATH="/Developer/NVIDIA/CUDA-5.0/lib:$DYLD_LIBRARY_PATH"

function prompt
{
  local WHITE="\[\033[1;37m\]"
  local GREEN="\[\033[0;32m\]"
  local CYAN="\[\033[0;36m\]"
  local GRAY="\[\033[0;37m\]"
  local BLUE="\[\033[0;34m\]"
  export PS1="${GREEN}\w${BLUE}"'$(__git_ps1 "(%s)")'" ${GRAY}"
  export PS2="${GREEN}| ${GRAY}"
}
prompt

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s /Users/mollerhoj3/.nvm/nvm.sh ]] && . /Users/mollerhoj3/.nvm/nvm.sh # This loads NVM
