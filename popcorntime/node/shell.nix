{ pkgs ? import ../../pkgs.nix }:
with import pkgs {};
with callPackage ../src.nix {};
stdenvNoCC.mkDerivation {
  name = "${pname}-node2nix-env-${version}";
  inherit src;
  nativeBuildInputs = [
    git nodePackages.node2nix
  ];
}
