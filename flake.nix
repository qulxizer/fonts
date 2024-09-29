{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      version = "3.2.1";
    in
    {
      packages.${system}.default = pkgs.stdenvNoCC.mkDerivation
        rec {
          pname = "FiraCode";
          inherit version;
          dontConfigue = true;
          src = pkgs.fetchzip {
            url =
              "https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${pname}.zip";
            hash = "sha256-R42y36YdFzyMbThhg3WeLs+uPrSjyiYDAvUWgt/rQg0=";
            stripRoot = false;
          };
          installPhase = ''
            mkdir -p $out/share/fonts
            cp -R $src $out/share/fonts/truetype/
          '';
        };

    };
}
