{ config, lib, pkgs, pkgs-unstable, secrets, ... }:

let
  cfg = config.qemu;
in
{
  options.qemu.enable = lib.mkEnableOption "Enable qemu";

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtiofsd
    ];

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [
      secrets.hosts.tiger.owner.username
    ];

    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
