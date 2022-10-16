# completion
[ -d $(brew --prefix)/share/zsh-completions ] && \
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
[ -r $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
  . $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
autoload -Uz compinit && compinit
zstyle ":completion:*:commands" rehash 1
zstyle ":completion:*:default" menu select=1

setopt auto_pushd
setopt pushd_ignore_dups
setopt no_list_beep

# editor
export EDITOR=emacs

# starship
if type starship > /dev/null 2>&1; then
  export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
  eval "$(starship init zsh)"
fi

. $ZDOTDIR/.zshrc.local
