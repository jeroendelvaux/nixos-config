{ config, lib, pkgs, pkgs-unstable, secrets, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = (lib.filesystem.listFilesRecursive ../../modules/nixos) ++ [
    ./hardware-configuration.nix
    secrets.nixosModules.m50741583
  ];

  qemu.enable = true;
  openvpn.enable = true;
  gc.enable = true;

  programs.hyprland.enable = true;
  environment.systemPackages = [
    pkgs.kitty # required for the default Hyprland config
  ];

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

  users.users.${secrets.user.name} = {
    isNormalUser = true;
    description = secrets.user.description;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "25.05"; # Do not change, even if the version in flake.nix is updated.
}
