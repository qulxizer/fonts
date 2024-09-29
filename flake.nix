{
  description =
    "A flake giving access to fonts that I use, outside of nixpkgs.";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          version = "3.2.1";
        in
        {
          packages.${system}.firaCode = pkgs.stdenvNoCC.mkDerivation
            rec {
              pname = "FiraCode";
              version = "3.2.1";
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
          defaultPackage.${system} = self.packages.${system}.firaCode;
        }
      );

}
