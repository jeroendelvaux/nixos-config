{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.nixos.wireshark;
in
{
  options.modules.nixos.wireshark = {
    enable = lib.mkEnableOption "Enable Wireshark";
    user = lib.mkOption {
      type = lib.types.str;
      description = "The username to grant Wireshark group access to.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    users.users.${cfg.user}.extraGroups = [ "wireshark" ];
  };
}
