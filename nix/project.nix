{ mkDerivation, aeson, base, base64-bytestring, binary, blaze-svg
, bytestring, containers, directory, executable-path, filepath
, hashable, haskeline, HPDF, JuicyPixels, mtl, natural-sort
, optparse-applicative, parsec, process, random, split, spool
, stdenv, template-haskell, text, time, vector, yaml, zlib
, pkgs
}:

let sourceByRegex = src: regexes: builtins.filterSource (path: type:
      let relPath = pkgs.lib.removePrefix (toString src + "/") (toString path); in
      let match = builtins.match (pkgs.lib.strings.concatStringsSep "|" regexes); in
      ( type == "directory"  && match (relPath + "/") != null
      || match relPath != null)) src; in

mkDerivation {
  pname = "tttool";
  version = "1.8";
  src = sourceByRegex ../. [
    "src/"
    "src/.*"
    ".*.cabal"
    "LICENSE"
    ];
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base base64-bytestring binary blaze-svg bytestring containers
    directory executable-path filepath hashable haskeline HPDF
    JuicyPixels mtl natural-sort optparse-applicative parsec process
    random split spool template-haskell text time vector yaml zlib
  ];
  homepage = "https://github.com/entropia/tip-toi-reveng";
  description = "Working with files for the Tiptoi® pen";
  license = stdenv.lib.licenses.mit;
}
