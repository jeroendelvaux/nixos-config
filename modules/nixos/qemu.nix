{ config, lib, pkgs, pkgs-unstable, secrets, ... }:

{
  options.qemu.enable = lib.mkEnableOption "Enable qemu";

  config = lib.mkIf config.qemu.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtiofsd # shared folder
    ];
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "${secrets.hosts.tiger.owner.username}" ];
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
