{ pkgs ? import ./pkgs.nix }:
let p = import pkgs {}; in
let pkgs = p; in let

name   = "popcorntime";
bundle = "$out/usr/share/" + name;

# https://github.com/popcorn-official/popcorn-desktop
# "development" branch, last commit on May 14, 2018
rev    = "be800aa98cb9ef16f7e00737bbc51ba69204ed8f";
sha256 = "05wpm6hvxza85lcfgwzi0alfmc2gnhz8fs8jsdvbnv5lyys53vw7";

src = fetchTarball {
  url = "https://github.com/popcorn-official/popcorn-desktop/archive/${rev}.tar.gz";
  inherit sha256;
};

bowerComponents = pkgs.buildBowerComponents {
  inherit name src;
  generated = ./bower;
};

nwjsPath = "cache/0.18.6-sdk/linux64/";
nwjsVersion = "0.31.5";
nwjs = pkgs.nwjs.overrideAttrs (x:
  let ffmpeg = pkgs.fetchurl {
    url = "https://github.com/iteufel/nwjs-ffmpeg-prebuilt/releases/download/${nwjsVersion}/${nwjsVersion}-linux-x64.zip";
    sha256 = "1p1y7yvia8d5ayqr61kki03k4papgbjl4ky8ffjz2g8zsl665x67";
  }; in {
    version = nwjsVersion;
    src = pkgs.fetchurl {
      url = "https://dl.nwjs.io/v${nwjsVersion}/nwjs-v${nwjsVersion}-linux-x64.tar.gz";
      sha256 = "1g0i2g1jlkp50616ng97ir7avff9w81z8x5gm86vp4az1lm672k0";
    };
    phases = ["unpackPhase" "patchPhase" "installPhase"];
    patchPhase = ''(
      cd lib
      ${pkgs.unzip}/bin/unzip -o ${ffmpeg}
    )'';
});

in (import ./node {

  inherit pkgs;
  system = pkgs.system;
  
}).package.override (x: {
  
  inherit src name;

  buildInputs = x.buildInputs ++ [
    (pkgs.writeShellScriptBin "guppy" "true")

    pkgs.nodePackages.node-gyp-build
    pkgs.nodePackages.gulp

    pkgs.phantomjs2
    pkgs.makeWrapper
  ];

  preRebuild = ''
    cp --no-preserve=mode -r ${bowerComponents}/bower_components/. src/app/vendor/
    rm       node_modules/bower/bin/bower
    touch    node_modules/bower/bin/bower
    chmod +x node_modules/bower/bin/bower
  '';

  postInstall = ''
    mkdir -p ${nwjsPath}
    cp --no-preserve=mode -r ${nwjs}/share/nwjs/. ${nwjsPath}

    gulp build

    mkdir -p ${bundle}
    cp -r build/Popcorn-Time/linux64/. ${bundle}
    chmod +x ${bundle}/Popcorn-Time

    mkdir -p $out/bin
    makeWrapper ${bundle}/Popcorn-Time $out/bin/${name}
    
    rm -r $out/lib
  '';
})
