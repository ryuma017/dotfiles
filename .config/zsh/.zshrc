if command -v brew > /dev/null 2>&1; then
  # completion
  [ -d ${HOMEBREW_PREFIX}/share/zsh-completions ] && \
    fpath=( ${HOMEBREW_PREFIX}/share/zsh-completions $fpath )
  [ -r ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
    source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  autoload -Uz compinit && compinit -d ${XDG_CACHE_HOME}/zsh/zcompdump
  zstyle ":completion:*:commands" rehash 1
  zstyle ":completion:*:default" menu select=1

  # syntax highlighting
  if [ -r ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    # define custom styles
    # ref: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
    source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    typeset -A ZSH_HIGHLIGHT_STYLES

    # main
    ZSH_HIGHLIGHT_STYLES[default]='none'
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=red'
    ZSH_HIGHLIGHT_STYLES[alias]='bold'
    ZSH_HIGHLIGHT_STYLES[precommand]='underline,bold'
    ZSH_HIGHLIGHT_STYLES[path]='fg=#96d0ff,underline'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=red'
    ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=red,underline'
    ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='none'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='none'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#96d0ff'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='none'
    ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='none'
    ZSH_HIGHLIGHT_STYLES[assign]='none'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=red'
    ZSH_HIGHLIGHT_STYLES[comment]='fg=black,bold'
    ZSH_HIGHLIGHT_STYLES[named-fd]='fg=red'
    ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=red'
    ZSH_HIGHLIGHT_STYLES[arg0]='bold'

    # brackets
    ZSH_HIGHLIGHT_HIGHLIGHTERS+=(brackets)
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#6cb6ff'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#6bc46d'
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#daaa3f'
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#ff938a'
    ZSH_HIGHLIGHT_STYLES[bracket-level-5]='fg=#fc8dc7'
    ZSH_HIGHLIGHT_STYLES[bracket-level-6]='fg=#dcbdfb'
  fi
fi

# prompt
if command -v starship > /dev/null 2>&1; then eval "$(starship init zsh)"; fi

# options
setopt auto_cd
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
