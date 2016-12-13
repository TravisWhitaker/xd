with import <nixpkgs> {};
runCommand "xd" {
    buildInputs = [ xorg.libX11
                    xorg.libXrandr
                    xorg.libXext
                    pkgconfig
                    stack
                    haskell.compiler.ghc801
                  ];
    LD_LIBRARY_PATH="${xorg.libX11}/lib/:${xorg.libXrandr}/lib/:${xorg.libXext}/lib/";
} ""
