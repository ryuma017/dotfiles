if type starship > /dev/null 2>&1; then
  export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship/starship.toml"
  export STARSHIP_CACHE="$XDG_CACHE_HOME/starship"
  eval "$(starship init zsh)"
fi
