# aliases
if type exa > /dev/null 2>&1; then
  alias ls='exa --icons --git'
  alias l='clear && ls'
  alias la='exa -a --icons --git'
  alias ll='exa -aahl --icons --git'
  alias lt='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
fi
if type bat > /dev/null 2>&1; then
  alias cat='bat'
fi
alias ..='cd ..'
alias ...='cd ../..'
alias c='clear'
alias pd='popd'
alias sudo='sudo '
alias emacs='emacs -nw'
alias em='emacs'

# emacs keybind
bindkey -e

. $ZDOTDIR/.zprofile.local
