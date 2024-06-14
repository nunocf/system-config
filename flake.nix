{
  description = "nunocf's flake";

  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build certain software.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Manages configs, links things to home directory
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Controls system level software and settings including fonts
    darwin = {
      url = "github:/lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nunocf-nvim.url = "github:nunocf/nixvim";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    darwin,
    home-manager,
    nunocf-nvim,
    ...
  }: let
    pkgs-stable = import nixpkgs-stable {system = "aarch64-darwin";};
  in {
    darwinConfigurations.Nunos-MacBook-Pro = darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      pkgs = import nixpkgs {system = "aarch64-darwin";};

      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit nunocf-nvim pkgs-stable;};
            users.nunocf.imports = [
              ./modules/home-manager
            ];
          };
        }
      ];
    };
  };
}
