{ pkgs ? import ./pkgs.nix {} }:
with pkgs;
let npm = import ./npm {
  inherit pkgs system;
};
in npm.shell.override (x: {
  dontNpmInstall = true;
  buildInputs = x.buildInputs ++ [
    nodePackages.node-gyp-build
  ];
})
