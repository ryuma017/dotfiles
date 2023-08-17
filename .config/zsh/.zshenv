setopt no_global_rcs
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# avoid duplicate entries
typeset -U path PATH fpath FPATH

# XDG Base Directory specification
export XDG_CONFIG_HOME="$HOME/.config"     # user-specific configurations
export XDG_CACHE_HOME="$HOME/.cache"       # user-specific non-essential (cached) data
export XDG_DATA_HOME="$HOME/.local/share"  # user-specific data files
export XDG_STATE_HOME="$HOME/.local/state" # user-specific state files (log, history, etc.)

# terminfo
export TERMINFO_DIRS=$TERMINFO_DIRS:$XDG_DATA_HOME/terminfo

# editor
export EDITOR=emacs

# disable less history
export LESSHISTFILE=-

# zsh_history
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=1000000
SAVEHIST=1000000

# homebrew
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=$HOME/Library/Fonts"
fi

if [ -d $ZDOTDIR/.zshenv.d ]; then
  for env in $ZDOTDIR/.zshenv.d/*.zsh; do
    if [ -r $env ]; then
      source $env
    fi
  done
fi

source $ZDOTDIR/.zshenv.local
