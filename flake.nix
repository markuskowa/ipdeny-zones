{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ] (system: function nixpkgs.legacyPackages.${system});

  in

  {

    packages = forAllSystems (pkgs:
    let
      zoneFiles = v: pkgs.stdenvNoCC.mkDerivation {
        name = "IP geo zone";
        src = ./.;

        installPhase = ''
          mkdir -p $out
          cp ipv${toString v}/* $out/
        '';
      };

    in {
        ipv4 = zoneFiles 4;
        ipv6 = zoneFiles 6;
        default = zoneFiles 4;
    });

  };
}
