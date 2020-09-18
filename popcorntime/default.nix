{ pkgs, system, fetchurl, unzip
, callPackage, writeShellScriptBin, makeWrapper
, nodePackages, buildBowerComponents
, nwjs, phantomjs2 }:

with callPackage ./src.nix {}; let

  bundle = "$out/usr/share/${pname}";

  bowerComponents = buildBowerComponents {
    inherit src;
    name = pname;
    generated = ./bower;
  };

  nwjsPath = "cache/0.18.6-sdk/linux64/";
  nwjsVersion = "0.31.5";
  nwjs' = nwjs.overrideAttrs (x: let
    ffmpeg = fetchurl {
      url = "https://github.com/iteufel/nwjs-ffmpeg-prebuilt/releases/download/${nwjsVersion}/${nwjsVersion}-linux-x64.zip";
      sha256 = "1p1y7yvia8d5ayqr61kki03k4papgbjl4ky8ffjz2g8zsl665x67";
    };
  in {
    version = nwjsVersion;
    src = fetchurl {
      url = "https://dl.nwjs.io/v${nwjsVersion}/nwjs-v${nwjsVersion}-linux-x64.tar.gz";
      sha256 = "1g0i2g1jlkp50616ng97ir7avff9w81z8x5gm86vp4az1lm672k0";
    };
    phases = ["unpackPhase" "patchPhase" "installPhase"];
    patchPhase = ''(
      cd lib
      ${unzip}/bin/unzip -o ${ffmpeg}
    )'';
  });

in (import ./node {

  inherit pkgs;
  system = system;

}).package.override (x: {

  inherit src;
  name = pname;

  buildInputs = x.buildInputs ++ [
    (writeShellScriptBin "guppy" "true")

    nodePackages.node-gyp-build
    nodePackages.gulp

    phantomjs2
    makeWrapper
  ];

  preRebuild = ''
    patch -p1 < ${./ext-player.patch}
    cp --no-preserve=mode -r ${bowerComponents}/bower_components/. src/app/vendor/
    > node_modules/bower/bin/bower
  '';

  postInstall = ''
    mkdir -p ${nwjsPath}
    cp --no-preserve=mode -r ${nwjs'}/share/nwjs/. ${nwjsPath}

    gulp build

    mkdir -p ${bundle}
    cp -r build/Popcorn-Time/linux64/. ${bundle}
    chmod +x ${bundle}/Popcorn-Time

    mkdir -p $out/bin
    makeWrapper ${bundle}/Popcorn-Time $out/bin/${pname}

    rm -r $out/lib
  '';
})
