self: super:
  with super; {
    # ocaml-ng = builtins.mapAttrs (_: ocamlVersion: ocamlVersion) super.ocaml-ng;
    # TODO: this is clearly not right, I should be overriding only 4_14
    ocaml-ng =
      ocaml-ng
      // (with ocaml-ng; {
        ocamlPackages_5_1 =
          ocamlPackages_5_1.overrideScope'
          (oself: osuper: {
            ocaml-lsp = osuper.ocaml-lsp.overrideAttrs (_: {
              src = fetchFromGitHub {
                owner = "EduardoRFS";
                repo = "ocaml-lsp";
                rev = "1434eda19bd8b8fee9d58a8af120a4e2217b2d18";
                sha256 = "7FdDc//mQLbUASwLw5AEH3JlIiuM2tvBQvE3Zv1gz88=";
                fetchSubmodules = true;
              };
            });
          });
      });
  }
