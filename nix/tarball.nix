######
#
# Author: Shea Levy
# Authoremail: sheaATshealevyDOTcom
# Start time: April, 2015
#
# Author: Brandon Barker
# Authoremail: first dot last at gmail . com
# Start time: October, 2018
#
######

{ stdenv
, ats2
, gmp
, autoconf
, automake
, version
}:

stdenv.mkDerivation rec {
  name = "ATS3-Xanadu-${version}.tgz";

  buildInputs = [ autoconf automake gmp ];

  src = builtins.filterSource (path: type:
    (toString path) != (toString ../.git)
  ) ../.;

  #
  # The following need to be fixed; check the package setupHook:
  #
  # PATSHOME = "${ats2}";
  # PATSHOMERELOC # set to ATS2-contrib dir if needed
  
  # configurePhase = ''
  #  patchShebangs doc/DISTRIB/ATS-Postiats/autogen.sh
  #  export XATSHOME=$PWD
  #  make -f codegen/Makefile_atslib
  # '';
 
  buildPhase = ''
    make -f srcgen/Makefile_stat
  '';

  # installPhase = ''
  #   mv doc/DISTRIB/${name} $out
  # '';

  shellHook = ''
    source ${ats2}/nix-support/setup-hook
    source ./nix/path_hack.sh
  '';
}

