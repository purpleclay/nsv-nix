# NSV NUR

This is managed by [GoReleaser Nixpkgs](https://goreleaser.com/customization/nix/) from within the [purpleclay/nsv](https://github.com/purpleclay/nsv/blob/main/.goreleaser.yaml) repository.

## Usage

Modify your `flake.nix` file to include a reference to this NUR:

```nix
{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    nsv = {
      url = "github:purpleclay/nsv-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = { self, nixpkgs, flake-utils, nsv }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [ nsv.packages.${system}.nsv ];
        };
      });
}
```

![Build and populate cache](https://github.com/purpleclay/nsv-nix/workflows/Build%20and%20populate%20cache/badge.svg)
