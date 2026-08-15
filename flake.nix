{
  description = "Multi-host NixOS and Home Manager configurations";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets.url = "git+ssh://git@github.com/jeroendelvaux/nixos-secrets.git";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = inputs.nixpkgs.lib;
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      secrets = inputs.secrets;
      specialArgs = {
        inherit lib;
        inherit pkgs-unstable;
        inherit secrets;
        inherit inputs;
      };
    in {
      nixosConfigurations = {
        # ----------------------------------------------------------------------
        # Host 1: tiger
        # ----------------------------------------------------------------------
        tiger = lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/tiger/configuration.nix
            inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
          ];
        };
        # ----------------------------------------------------------------------
        # Host 2: puma
        # ----------------------------------------------------------------------
        puma = lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./hosts/puma/configuration.nix
            inputs.sops-nix.nixosModules.sops
          ];
        };
      };

      homeConfigurations = {
        # ----------------------------------------------------------------------
        # Host 3: leopard
        # ----------------------------------------------------------------------
        # TODO
      };
    };
}
