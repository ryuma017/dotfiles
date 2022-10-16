if type sccache > /dev/null 2>&1; then
  export RUSTC_WRAPPER=$(which sccache)
fi
