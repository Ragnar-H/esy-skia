{
  description = "nix development shell for rust-skia";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages."${system}";
      in {
        devShell = pkgs.mkShell {
          SKIA_NINJA_COMMAND = "${pkgs.ninja}/bin/ninja";
          SKIA_GN_COMMAND = "${pkgs.gn}/bin/gn";
          # LIBCLANG_PATH = "${pkgs.llvmPackages.libclang}/lib/libclang.so";

          # necessary to override nix's defaults which cannot be overriden as others are
          # shellHook = ''
          #   export CC="${pkgs.clang}/bin/clang"
          #   export CXX="${pkgs.clang}/bin/clang++"
          #   '';

          # buildPhase = ''
          #   NIX_CFLAGS_COMPILE="$(pkg-config --cflags gtk+-3.0) $NIX_CFLAGS_COMPILE"
          #   # put the usual make/gcc code here
          # '';

          buildInputs = with pkgs; [
            fontconfig.dev
          ];
          nativeBuildInputs = with pkgs; [
            clang
            pkg-config
            # fontconfig
            gn
            nasm
            ninja
            nodePackages.esy
            python
            # rustup
          ];
        };
      });
}