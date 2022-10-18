# completion
if type brew > /dev/null 2>&1; then
  [ -d $(brew --prefix)/share/zsh-completions ] && \
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  [ -r $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    . $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit -d $XDG_CACHE_HOME/zsh/zcompdump
  zstyle ":completion:*:commands" rehash 1
  zstyle ":completion:*:default" menu select=1
fi

setopt auto_pushd
setopt pushd_ignore_dups
setopt no_list_beep

. $ZDOTDIR/.zshrc.local
