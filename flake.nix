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
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    nunocf-nvim.url = "github:nunocf/nixvim";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-stable,
    darwin,
    home-manager,
    nix-homebrew,
    nunocf-nvim,
    ...
  }: let
    pkgs-stable = import nixpkgs-stable {system = "aarch64-darwin";};
    username = "nunocf";
    hostname = "Nunos-MacBook-Pro";
  in {
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import nixpkgs {system = "aarch64-darwin";};
      specialArgs = {inherit username;};

      modules = [
        ./modules/darwin
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            enableRosetta = true;

            # User owning the Homebrew prefix
            user = username;

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit nunocf-nvim pkgs-stable username;};
            users."${username}".imports = [
              ./modules/home-manager
            ];
          };
        }
      ];
    };
  };
}
