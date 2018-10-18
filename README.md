# Popcorn Time package for NixOS

This is a Nix package of [popcorn-official/popcorn-desktop](https://github.com/popcorn-official/popcorn-desktop) ("development" branch, [this commit](https://github.com/popcorn-official/popcorn-desktop/commit/be800aa98cb9ef16f7e00737bbc51ba69204ed8f)).

On NixOS, you can build and install this package with the following command. Although it has not been tested, this could also work on other linux systems provided you have installed the [Nix package manager](https://nixos.org/nix).
```
nix-env -if https://github.com/timjrd/popcorntime.nix/archive/master.tar.gz
```
the `popcorntime` command should now be available.

At least two dependencies are not built from source: [nwjs](https://nwjs.io/) and [ffmpeg](https://github.com/iteufel/nwjs-ffmpeg-prebuilt).
