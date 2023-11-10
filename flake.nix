{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs { inherit system; };

      mkWgslAnalyzer =
        { lib
        , ...
        }:
        pkgs.rustPlatform.buildRustPackage rec {
          pname = "wgsl-analyzer";
          version = "0.8.0";

          src = pkgs.fetchFromGitHub {
            owner = "wgsl-analyzer";
            repo = pname;
            rev = version;
            sha256 = "bYlKLFWsndiIraTCF8UD771JH+MZUto5pfszG0gD4GU=";
          };

          cargoLock.lockFile = "./Cargo.lock";

          cargoSha256 = "";

          meta = {
            description = "A language server implementation for the WGSL shading language";
            homepage = "https://github.com/wgsl-analyzer/wgsl-analyzer";
            license = lib.licenses.mit;
          };
        };
    in
    {

      overlays.default = final: prev: {
        wgsl-analyzer = pkgs.callPackage mkWgslAnalyzer { };
      };

    };
}
