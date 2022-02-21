let
  pkgs = import <nixpkgs> { };

  haskellPackages = pkgs.haskellPackages.override {
    overrides = hself: hsuper: {
      "stasi" =
        hself.callCabal2nix "stasi" ./. { };
    };
  };

  shell = haskellPackages.shellFor {
    packages = p: [
      p."stasi"
    ];
    buildInputs = [
      # Haskell development
      pkgs.haskell-language-server
      pkgs.cabal-install
      pkgs.hlint
    ];
    withHoogle = true;
  };
in
{
  inherit shell;
  inherit haskellPackages;
  "stasi" = haskellPackages."stasi";
}
