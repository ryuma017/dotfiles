# aliases
if command -v exa > /dev/null 2>&1; then
  alias ls='exa --git'
  alias l='clear && ls'
  alias la='exa -a --git'
  alias ll='exa -aahl --git'
  alias lt='exa -T -L 3 -a -I "node_modules|.git|.cache"'
  alias lta='exa -T -a -I "node_modules|.git|.cache" --color=always | less -r'
else
  alias ls='ls --color=auto'
  alias l='clear && ls'
  alias la='ls -a'
  alias ll='ls -ahl'
fi

alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias pd='popd'
alias sudo='sudo '
alias em='emacs -nw'

# emacs keybind
bindkey -e

source $ZDOTDIR/.zprofile.local
