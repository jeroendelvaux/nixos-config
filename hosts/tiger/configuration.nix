{ config, lib, pkgs, pkgs-unstable, secrets, inputs, ... }:

{
  imports = 
    (lib.filesystem.listFilesRecursive ./modules)
    ++ (lib.filesystem.listFilesRecursive ../../modules/nixos)
    ++ [
      ./hardware-configuration.nix
      secrets.nixosModules.m50741583
    ];

  config.nix.settings.experimental-features = [ "nix-command" "flakes" ];

  config.nixpkgs.config.allowUnfree = true;
  config.nixpkgs.overlays = [ inputs.nur.overlays.default ];

  config.wireguard.enable = true;
  config.qemu.enable = true;
  config.gc.enable = true;

  config.programs.hyprland.enable = true;

  config.services.gnome.gnome-keyring.enable = true;
  config.programs.dconf.enable = true; 
  config.security.polkit.enable = true;

  config.security.pam.services = {
    greetd.enableGnomeKeyring = true;
  };

  config.boot.loader.systemd-boot.enable = true;
  config.boot.loader.efi.canTouchEfiVariables = true;

  config.environment.shells = with pkgs; [ bash ];
  config.users.defaultUserShell = pkgs.bash;

  config.services.gvfs.enable = true;
  config.services.udisks2.enable = true;

  config.services.automatic-timezoned.enable = true;

  config.users.users.${secrets.hosts.tiger.owner.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
       inherit pkgs-unstable secrets inputs;
    };
    users.${secrets.hosts.tiger.owner.username} = {
      imports = [
        ./home.nix
        inputs.nixvim.homeModules.nixvim
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };

  config.system.stateVersion = "25.05";
}
