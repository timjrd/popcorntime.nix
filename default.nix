{ pkgs ? import ./pkgs.nix }:
with import pkgs {}; {
  popcorntime = callPackage ./popcorntime {};
}
