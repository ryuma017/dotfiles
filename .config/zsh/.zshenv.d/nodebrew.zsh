if type nodebrew > /dev/null 2>&1; then
  export NODEBREW_ROOT="$XDG_DATA_HOME/nodebrew"
  export PATH=$NODEBREW_ROOT/current/bin:$PATH
fi
