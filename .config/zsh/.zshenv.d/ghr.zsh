if type ghr > /dev/null 2>&1; then
  export GHR_ROOT=$HOME/.local/src/github.com
  eval "$(ghr shell bash)"
  set +eu
fi
