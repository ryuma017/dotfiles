setopt no_global_rcs
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

export DOTFILES_HOME=""

# XDG Base Directory specification
export XDG_CONFIG_HOME="$HOME/.config"     # user-specific configurations
export XDG_CACHE_HOME="$HOME/.cache"       # user-specific non-essential (cached) data
export XDG_DATA_HOME="$HOME/.local/share"  # user-specific data files
export XDG_STATE_HOME="$HOME/.local/state" # user-specific state files (log, history, etc.)

# history files
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

# editor
export EDITOR=emacs

# zsh_history options
HISTSIZE=1000000
SAVEHIST=1000000
setopt extended_history
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
setopt hist_no_store
setopt no_flow_control

# homebrew
if [ -d /opt/homebrew/bin ]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export HOMEBREW_AUTO_UPDATE_SECS=3600
  export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=$HOME/Library/Fonts"
fi

# source `$ZDOTDIR/.zshenv.d/*.zsh`
if [ -d $ZDOTDIR/.zshenv.d ]; then
  for env in $ZDOTDIR/.zshenv.d/*.zsh; do
    if [ -r $env ]; then
      . $env
    fi
  done
fi

. $ZDOTDIR/.zshenv.local
