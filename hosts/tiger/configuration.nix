{ lib, pkgs, pkgs-unstable, secrets, inputs, ... }:

{
  imports = 
    (lib.filesystem.listFilesRecursive ./modules)
    ++ (lib.filesystem.listFilesRecursive ../../modules/nixos)
    ++ [
      ./hardware-configuration.nix
      secrets.nixosModules.m50741583
    ];

  config = {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.overlays = [
      inputs.niri.overlays.niri
      inputs.nur.overlays.default
    ];

    wireguard.enable = true;
    qemu.enable = true;
    gc.enable = true;

    # Because Wayland compositor (Niri) is managed solely through Home Manager:
    environment.pathsToLink = [
      "/share/applications"
      "/share/xdg-desktop-portal"
    ];
    programs = {
      dconf.enable = true;
    };

    services = {
      upower.enable = true;
      gnome.gnome-keyring.enable = true;
      gvfs.enable = true;
      udisks2.enable = true;
      automatic-timezoned.enable = true;
    };

    security = {
      polkit.enable = true;
      pam.services.greetd.enableGnomeKeyring = true;
    };

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    environment.systemPackages = with pkgs; [
      killall
    ];
    environment.shells = with pkgs; [ bash ];
    users = {
      defaultUserShell = pkgs.bash;
      users.${secrets.hosts.tiger.owner.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
      };
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
          inputs.niri.homeModules.niri
          inputs.nixvim.homeModules.nixvim
          inputs.sops-nix.homeManagerModules.sops
        ];
      };
    };

    system.stateVersion = "25.05";
  };
}
