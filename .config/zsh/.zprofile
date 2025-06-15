if cmd-exists eza; then
  alias ls='eza --git'
  alias la='eza -a --git'
  alias ll='eza -hl --git'
  alias lla='eza -ahl --git'
else
  alias ls='ls --color=auto'
  alias la='ls -a'
  alias ll='ls -hl'
  alias lla='ls -ahl'
fi

alias c='clear'
alias pd='popd'
alias sudo='sudo '
alias vim='nvim'

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

fpath=(
  ${fpath}
  /Applications/OrbStack.app/Contents/MacOS/../Resources/completions/zsh(N-/)
)

[ -r "${ZDOTDIR}/.zprofile.local" ] && . "${ZDOTDIR}/.zprofile.local"
