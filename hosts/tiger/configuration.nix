{ config, lib, pkgs, pkgs-unstable, secrets, inputs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config = {
    allowUnfree = true;
    permitInsecurePredicate = _: true;
    permittedInsecurePackages = [
      "electron-39.8.10"
      "ventoy-gtk3-1.1.05"
      "mbedtls-2.28.10"
    ];
  };
  # TODO: redesign structure for insecure packages

  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];

  imports = 
    (lib.filesystem.listFilesRecursive ./modules)
    ++ (lib.filesystem.listFilesRecursive ../../modules/nixos)
    ++ [
      ./hardware-configuration.nix
      secrets.nixosModules.m50741583
    ];

  wireguard.enable = true;
  qemu.enable = true;
  gc.enable = true;

  programs.hyprland.enable = true;

  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true; 
  security.polkit.enable = true;

  security.pam.services = {
    greetd.enableGnomeKeyring = true; # unlocks GNOME keyring on login
  };

  # Bootloader:
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Shells:
  environment.shells = with pkgs; [ bash ];
  users.defaultUserShell = pkgs.bash;

  # USB:
  services.gvfs.enable = true;
  services.udisks2.enable = true; # udisksctl

  services.automatic-timezoned.enable = true; # Update time zone based on current location

  users.users.${secrets.hosts.tiger.owner.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
       inherit pkgs-unstable secrets inputs;
    };
    users.${secrets.hosts.tiger.owner.username} = {
      imports = [
        ./home.nix
        inputs.nixvim.homeModules.nixvim
        inputs.nur.modules.homeManager.default
        inputs.sops-nix.homeManagerModules.sops
      ];
    };
  };

  system.stateVersion = "25.05"; # Do not change, even if the version in flake.nix is updated.
}
