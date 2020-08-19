{ lib, writeScript, writeScriptBin, bashInteractive }:

# Recommended base packages are [ coreutils gnugrep gnused gawk less ]
{ name, binName ? "env-${name}", packages, bashrc ? "" }:

# TODO: find a less ugly way
# TODO: pass through HOME and TERM
let
  rcfile = writeScript "${name}-rcfile" (''
    export IN_NIX_SHELL=pure

    export PS1='\n\[\033[1;32m\][${name}-shell:\w]\$\[\033[0m\] ';

    # Set temp dir
    export TMP=/tmp/shell-environments-${name}
    export TEMP=$TMP
    export TMPDIR=$TMP
    export TEMPDIR=$TMP
    # Make sure it exists
    mkdir -p $TMP

  '' + bashrc);
  script = writeScript "${name}-setup" ''
    export PATH=${lib.makeBinPath ([ bashInteractive ] ++ packages)}
    export __ETC_PROFILE_SOURCED=1
    ${bashInteractive}/bin/bash --rcfile ${rcfile}
  '';
in writeScriptBin binName ''
  env -i -S sh -c ${script}
''
