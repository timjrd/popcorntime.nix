# Popcorn Time package for NixOS
**DISCLAIMER: Use this package at your own risk. You might want to use a sandbox.**


This is a Nix package of the development branch of [popcorn-official/popcorn-desktop](https://github.com/popcorn-official/popcorn-desktop). It has been tested on NixOS 18.09.


## Installation

On NixOS, you can build and install this package with the following command:
```
nix-env -if https://github.com/timjrd/popcorntime.nix/archive/master.tar.gz
```
Alternatively, you can try:
```
nix-env --arg pkgs '<nixpkgs>' -if https://github.com/timjrd/popcorntime.nix/archive/master.tar.gz
```
The `popcorntime` command should now be available.


## Non-NixOS GNU/Linux and macOS

Although it has not been tested, this package could also work on other linux systems provided you have installed the [Nix package manager](https://nixos.org/nix). Let me now if it doesn't work.

Nix is available on macOS but this package won't build there. Let me now if you are interested.


## Notes

At least two dependencies are not built from source: [nwjs](https://nwjs.io/) and [nwjs's ffmpeg](https://github.com/iteufel/nwjs-ffmpeg-prebuilt).

There are two tiny patches: one adding `~/.nix-profile/bin/` to Popcorn Time's search path for external players, and a quick & dirty fix concerning subtitles and external players.
