let
  pkgs = import <nixpkgs>  { };
in

with pkgs;

mkShell {
  buildInputs = (with ocamlPackages; [ fontconfig nodejs-14_x nodePackages.esy ]);
  nativeBuildInputs = [ unzip
  coreutils
  nasm
  clang
  python2
  cmake
  ragel
  libpng
  harfbuzz
  gtk3
  fontconfig
  gn
  ninja
  ];
}
