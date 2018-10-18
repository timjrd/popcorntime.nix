let rev    = "c06f5302f63af92c9ba0e10401f366e0c7bd7d49"; # nixos-18.09 on Oct 15, 2018
    sha256 = "01fnr797a6iv3cy8gmddmm5gdlrijjdm66y9v14jai3np8fx1nyz";
in fetchTarball {
  url = "https://github.com/NixOS/nixpkgs-channels/archive/${rev}.tar.gz";
  inherit sha256;
}
