{ pkgs ? import ../../pkgs.nix }:
with import pkgs {};
with callPackage ../src.nix {};
stdenvNoCC.mkDerivation {
  name = "${pname}-bower2nix-env-${version}";
  inherit src;
  nativeBuildInputs = [
    git nodePackages.bower2nix
  ];
}
