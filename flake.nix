{
  description = "Linux kernel debug (by QEMU)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
        llvm = pkgs.llvmPackages_19;
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.clang-tools
            llvm.clang
            llvm.lldb
          ];
        };
      }
    );
}
