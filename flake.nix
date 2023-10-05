{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";

    nixpkgs.url = "github:anmonteiro/nix-overlays";
    nixpkgs.inputs.flake-utils.follows = "flake-utils";
    nixpkgs.inputs.nix-filter.follows = "nix-filter";

    melange.url = "github:melange-re/melange";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nix-filter,
    melange,
  }: let
    out = system: let
      pkgs =
        (import nixpkgs {
          inherit system;
          extraOverlays = [
            melange.overlays.default
          ];
        })
        .extend (self: super: {
          ocamlPackages = super.ocaml-ng.ocamlPackages_5_1;
        });
      inherit (pkgs) lib;
      myPkgs =
        pkgs.recurseIntoAttrs
        (import ./nix {
          inherit pkgs;
          nix-filter = nix-filter.lib;
          doCheck = true;
        })
        .native;
      myDrvs = lib.filterAttrs (_: value: lib.isDerivation value) myPkgs;
    in {
      devShell = pkgs.mkShell {
        inputsFrom = lib.attrValues myDrvs;
        buildInputs = with pkgs;
        with ocamlPackages; [
          gnumake
          ocamlPackages.melange
          ocaml-lsp
          ocamlformat
          odoc
          ocaml
          dune_3
          nixfmt
        ];
      };

      defaultPackage = myPkgs.service;

      defaultApp = {
        type = "app";
        program = "${self.defaultPackage.${system}}/bin/service";
      };
    };
  in
    with flake-utils.lib; eachSystem defaultSystems out;
}
