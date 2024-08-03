{
  description = "twoeasteroid's Literate NixOS configuration1";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11"
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = { self, nixpkgs, home-manager, ... }
    @ inputs:

      let
        inherit (self) outputs;
      in {

        nixosConfigurations = {
          civilisation = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs outputs};
            modules = [./nixos/configuration.nix];
          };
        };

        homeConfigurations = {
          "tautology@civilisation" = home-manager.lib.homeManagerConfiguratioen {
            pkgs = nixpkgs.legacyPackages.m86_64-linux;
            extraSpecialArgs = {inherit inputs outputs};
            modules = [./home-manager/home.nix];
          };
        };
      };
};
