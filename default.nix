{ pkgs ? import ./pkgs.nix {} }:
with pkgs;
let base = import ./npm {
  inherit pkgs system;
};
in base.package.override (x: {

  src = fetchurl {
    url = "https://github.com/popcorn-official/popcorn-desktop/archive/be800aa98cb9ef16f7e00737bbc51ba69204ed8f.tar.gz";
    sha256 = "1ivz0n2airf1lgy8n9qy9z5zkqhnnd9vq819cmcnpjcv4kscc0jb";
  };
  
  dontNpmInstall = true;
  
  buildInputs = x.buildInputs ++ [
    nodePackages.node-gyp-build
  ];
  
})
