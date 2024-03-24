# options
setopt append_history
setopt auto_cd
setopt auto_pushd
setopt complete_in_word
setopt pushd_ignore_dups
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt inc_append_history
setopt notify
setopt share_history
setopt sh_word_split
unsetopt flow_control
unsetopt list_beep
unsetopt no_match

if [ -z "$TMUX" ] && cmd-exists tmux; then
  exec tmux new -As "stuff"
fi

# prompt
if cmd-exists starship; then
  eval "$(starship init zsh)"
fi

# history
[ -d "${XDG_STATE_HOME}/zsh" ] || mkdir -p "${XDG_STATE_HOME}/zsh"
HISTFILE="${XDG_STATE_HOME}/zsh/history"
HISTSIZE=10000000
SAVEHIST=10000000

# set the built-in time format to be more like bash
TIMEFMT=$'\nreal\t%*E\nuser\t%*U\nsys\t%*S\nmaxmem\t%M MB\nfaults\t%F'

# completions
[ -d "${HOMEBREW_PREFIX}/share/zsh-completions" ] && \
  fpath=( "${HOMEBREW_PREFIX}/share/zsh-completions" $fpath )
[ -d "${XDG_CACHE_HOME}/zsh" ] || mkdir -p "${XDG_CACHE_HOME}/zsh"
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump"
zstyle ":completion:*:commands" rehash 1
zstyle ":completion:*:default" menu select=1

# auto suggestions
[ -r "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
  . "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# source local configuration
[ -r "${ZDOTDIR}/.zshrc.local" ] && . "${ZDOTDIR}/.zshrc.local"

# syntax highlighting
# this must be the sourced at the end of the file
# see: https://github.com/zsh-users/zsh-syntax-highlighting?tab=readme-ov-file#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
zle_highlight=( region:bg=11 )
[ -r "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
  . "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
