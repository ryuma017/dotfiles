# completion
if command -v brew > /dev/null 2>&1; then
  [ -d ${HOMEBREW_PREFIX}/share/zsh-completions ] && \
    fpath=( ${HOMEBREW_PREFIX}/share/zsh-completions $fpath )
  [ -r ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump
  zstyle ":completion:*:commands" rehash 1
  zstyle ":completion:*:default" menu select=1
fi

# prompt
if command -v starship > /dev/null 2>&1; then eval "$(starship init zsh)"; fi

# options
setopt auto_pushd
setopt pushd_ignore_dups
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt inc_append_history
setopt share_history
unsetopt flow_control
unsetopt list_beep

source ${ZDOTDIR}/.zshrc.local
