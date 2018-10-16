args:
let rev    = "d16a7abceb72aac85e0deb8c45fbcb7127baf628"; # nixos-18.03 on Sep 21, 2018
    sha256 = "0byf6rlwwy70v2sdfmv7mnwd0kvxmlq0pi8ijghg0mcfhcqibgh7";
in import (fetchTarball {
  url = "https://github.com/NixOS/nixpkgs-channels/archive/${rev}.tar.gz";
  inherit sha256;
}) args
