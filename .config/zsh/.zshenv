# do not read any subsequent global startup files
unsetopt global_rcs

# XDG Base Directory specification
export XDG_CONFIG_HOME="$HOME/.config"     # user-specific configurations
export XDG_CACHE_HOME="$HOME/.cache"       # user-specific non-essential (cached) data
export XDG_DATA_HOME="$HOME/.local/share"  # user-specific data files
export XDG_STATE_HOME="$HOME/.local/state" # user-specific state files (log, history, etc.)

# avoid duplicate entries
typeset -U path fpath PATH FPATH

# obtain default PATH and MANPATH from /etc/{paths,manpaths,paths.d/*,manpaths.d/*}
#if [ -x /usr/libexec/path_helper ]; then
#  eval "$(/usr/libexec/path_helper -s)"
#if

# homebrew
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  for bin in "${HOMEBREW_PREFIX}/opt/"*"/libexec/gnubin"; do
    export PATH=$bin:$PATH
  done
  #for bin in "${HOMEBREW_PREFIX}/opt/"*"/bin"; do
  #  export PATH=$bin:$PATH
  #done
  for man in "${HOMEBREW_PREFIX}/opt/"*"/libexec/gnuman"; do
    export MANPATH=$man:$MANPATH
  done
  #for man in "${HOMEBREW_PREFIX}/opt/"*"/share/man/man1"; do
  #  export MANPATH=$man:$MANPATH
  #done
fi

if [ -d "${ZDOTDIR}/.zshenv.d" ]; then
  for env in "${ZDOTDIR}/.zshenv.d"/*; do
    if [ -r "$env" ]; then
      . "$env"
    fi
  done
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# terminfo
export TERMINFO_DIRS="${XDG_DATA_HOME}/terminfo${TERMINFO_DIRS+:}"

# editor
export EDITOR=nvim

# disable less history
export LESSHISTFILE=-

. "${ZDOTDIR}/.zshenv.local"
