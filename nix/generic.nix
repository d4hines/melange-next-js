{
  pkgs,
  stdenv,
  lib,
  ocamlPackages,
  static ? false,
  doCheck,
  nix-filter,
}:
with ocamlPackages; rec {
  service = buildDunePackage {
    pname = "service";
    version = "0.1.0";

    src = nix-filter {
      root = ../.;
      include = [
        "src"
        "dune-project"
        "service.opam"
      ];
    };

    # Static builds support, note that you need a static profile in your dune file
    buildPhase = ''
      echo "running ${
        if static
        then "static"
        else "release"
      } build"
      dune build --display=short --profile=${
        if static
        then "static"
        else "release"
      }
    '';
    installPhase = ''
      mkdir -p $out/bin
      cp "$(readlink -f _build/install/default/bin/service)" "$out/bin/service"
    '';

    checkInputs = [
    ];

    propagatedBuildInputs = [
      piaf
      lwt
      yojson

      ppx_expect
    ];

    inherit doCheck;

    meta = {
      description = "Your service";
    };
  };
}
