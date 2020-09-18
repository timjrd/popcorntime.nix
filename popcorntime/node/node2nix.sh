#! /usr/bin/env nix-shell
#! nix-shell -i bash
node2nix --development --input $src/package.json
