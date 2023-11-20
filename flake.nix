{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    systems.url = "github:nix-systems/default";
    # Dev tools
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs = { self, flake-parts, ... }@ inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = import inputs.systems;
      imports = [
        inputs.treefmt-nix.flakeModule
      ];
      perSystem = { config, self', pkgs, lib, system, rust-overlay, ... }:
        let
          buildInputs = with pkgs; [ ];
          nativeBuildInputs = with pkgs; [
            zulu11
            sbt
          ];
        in
        {
          devShells.default = pkgs.mkShell {
            inputsFrom = [
              config.treefmt.build.devShell
            ];
            shellHook = ''
              echo
              echo "Run 'just <recipe>' to get started 🚀🚀🚀"
              just
            '';

            inherit buildInputs;
            nativeBuildInputs = nativeBuildInputs ++ (with pkgs; [
              just
              metals
              coursier
              scalafmt
            ]);
          };

          treefmt.config = {
            projectRootFile = "flake.nix";
            programs = {
              nixpkgs-fmt.enable = true;
              scalafmt.enable = true;
            };
          };
        };
    };
}
