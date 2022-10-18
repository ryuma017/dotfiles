if [ -d /opt/homebrew/bin ]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export HOMEBREW_AUTO_UPDATE_SECS=3600
  export HOMEBREW_CASK_OPTS="--appdir=/Applications --fontdir=$HOME/Library/Fonts"
fi
