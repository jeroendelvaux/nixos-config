{ config, lib, pkgs, ... }:

let
  cfg = config.modules.nixos.qemu;
in
{
  options.modules.nixos.qemu = {
    enable = lib.mkEnableOption "QEMU";
    user = lib.mkOption {
      type = lib.types.str;
      description = "The username to grant QEMU group access to.";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      qemu
      virtiofsd
    ];

    programs.virt-manager.enable = true;

    users.groups.libvirtd.members = [ cfg.user ];

    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };
  };
}
