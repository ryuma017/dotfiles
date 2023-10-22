if command -v ghr > /dev/null 2>&1; then
  export GHR_ROOT="$HOME/.local/src"
  . <(ghr shell bash)
fi
