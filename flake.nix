{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    nix-filter.url = "github:numtide/nix-filter";

    ocaml-overlay.url = "github:nix-ocaml/nix-overlays";
    ocaml-overlay.inputs.nixpkgs.follows = "nixpkgs";
    ocaml-overlay.inputs.flake-utils.follows = "flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    nix-filter,
    ocaml-overlay,
  }: let
    out = system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ocaml-overlay.overlays.${system}];
      };
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
