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
    lib = inputs.nixpkgs.lib;
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    secrets = inputs.secrets;
  in {
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
    devShells.${system} = {
      arm = import ../../shells/arm.nix { pkgs = pkgs-unstable; };
    };
  };
}
