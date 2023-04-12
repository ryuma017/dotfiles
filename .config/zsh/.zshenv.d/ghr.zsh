if type ghr > /dev/null 2>&1; then
  export GHR_ROOT=$HOME/.local/src
  source <(ghr shell bash)
fi
