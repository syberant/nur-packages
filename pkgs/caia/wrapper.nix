{ writeScriptBin, caia-unwrapped }:

writeScriptBin "caia" ''
  export CAIA_BIN_DIR=${caia-unwrapped}/caia/zuniq/bin

  ${caia-unwrapped}/bin/caiaio -m $CAIA_BIN_DIR/manager $@
''
