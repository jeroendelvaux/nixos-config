{
  description = "My flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      #inputs.nixpkgs.follows = "nixpkgs";
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
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    secrets = inputs.secrets;
  in {
    nixosConfigurations = let
      lib = inputs.nixpkgs.lib;
    in {
      nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          inputs.sops-nix.nixosModules.sops
        ];
        specialArgs = {
          inherit lib;
          inherit pkgs-unstable;
          inherit secrets;
        };
      };
    };
    homeConfigurations = {
      default = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
          inputs.nixvim.homeModules.nixvim
          inputs.nur.modules.homeManager.default
          inputs.sops-nix.homeManagerModules.sops
        ];
        extraSpecialArgs = {
          inherit secrets;
        };
      };
    };
  };
}
