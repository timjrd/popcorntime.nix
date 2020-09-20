let
  fetch = {url, rev, sha256}: fetchTarball {
    url = "${url}/archive/${rev}.tar.gz";
    inherit sha256;
  };
in fetch {
  url = https://github.com/NixOS/nixpkgs-channels;
  rev = "faf5bdea"; # nixos-20.03 on Sep 17, 2020
  sha256 = "1sgfyxi4wckivnbniwmg4l6n9v5z6v53c5467d7k7pr2h6nwssfn";
}
