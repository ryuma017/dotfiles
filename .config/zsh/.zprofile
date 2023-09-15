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

alias c='clear'
alias pd='popd'
alias sudo='sudo '
alias em='emacs -nw'

# emacs keybind
bindkey -e

pbcopy-as-kill-line() {
  zle kill-line
  print -nr "$CUTBUFFER" | pbcopy
}
zle -N pbcopy-as-kill-line
bindkey '^K' pbcopy-as-kill-line

pbpaste-as-yank() {
  emulate -L zsh
  local sys_clip="$(pbpaste)"
  if [[ "$sys_clip" != "$CUTBUFFER" ]]; then
    killring=("$CUTBUFFER" "${(@)killring[1,-2]}")
    CUTBUFFER="$sys_clip"
  fi
  zle yank
}
zle -N pbpaste-as-yank
bindkey '^Y' pbpaste-as-yank

show-buffers()
{
    local nl=$'\n' kr
    typeset -T kr KR ' '
    typeset +g -a buffers
    KR=($killring)
    buffers+="      Pre: ${PREBUFFER:-$nl}"
    buffers+="  Buffer: $BUFFER$nl"
    buffers+="     Cut: $CUTBUFFER$nl"
    buffers+="       L: $LBUFFER$nl"
    buffers+="       R: $RBUFFER$nl"
    buffers+="Killring: ( $kr )$nl"
    zle -M "$buffers"
}
zle -N show-buffers
bindkey "^[o" show-buffers

source "${ZDOTDIR}/.zprofile.local"
