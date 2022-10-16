setopt no_global_rcs
if [ -x /usr/libexec/path_helper ]; then
  eval `/usr/libexec/path_helper -s`
fi

# XDG base
export XDG_CONFIG_HOME="$HOME/.config"     # user-specific configurations
export XDG_CACHE_HOME="$HOME/.cache"       # user-specific non-essential (cached) data
export XDG_DATA_HOME="$HOME/.local/share"  # user-specific data files
export XDG_STATE_HOME="$HOME/.local/state" # user-specific state files (log, history, etc.)

# history files
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_history"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export LESSHISTFILE="$XDG_STATE_HOME/less_history"
# zsh_history options
HISTFILE=$XDG_STATE_HOME/zsh_history
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
export PATH="/opt/homebrew/bin:$PATH"

source $ZDOTDIR/.zshenv.local
