let
  fetch = {url, rev, sha256}: fetchTarball {
    url = "${url}/archive/${rev}.tar.gz";
    inherit sha256;
  };
in fetch {
  url = https://github.com/NixOS/nixpkgs-channels;
  rev = "c06f5302"; # nixos-18.09 on Oct 15, 2018
  sha256 = "01fnr797a6iv3cy8gmddmm5gdlrijjdm66y9v14jai3np8fx1nyz";
}
