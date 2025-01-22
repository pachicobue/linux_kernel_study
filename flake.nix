{
  description = "Linux kernel debug (by QEMU)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          devShells.default =
            (pkgs.buildFHSEnv {
              name = "buildroot";
              targetPkgs =
                pkgs:
                (
                  with pkgs;
                  [
                    (lib.hiPrio gcc)
                    file
                    gnumake
                    ncurses.dev
                    pkg-config
                    unzip
                    wget
                    pkgsCross.aarch64-multiplatform.gccStdenv.cc
                  ]
                  ++ pkgs.linux.nativeBuildInputs
                );
            }).env;
        };
      flake = {
      };
    };
}
