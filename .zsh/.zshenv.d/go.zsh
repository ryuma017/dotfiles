if [ -d /usr/local/go/bin ]; then
  export GOPATH="$XDG_DATA_HOME/go"
  export GOMODCACHE="$XDG_CACHE_HOME/go-mod"
  export GOBIN="$GOPATH/bin"
  export PATH="$GOBIN:/usr/local/go/bin:$PATH"
fi
