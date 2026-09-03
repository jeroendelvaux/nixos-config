{ config, lib, pkgs, pkgs-unstable, secrets, ... }:

let
  cfg = config.modules.wireshark;
in
{
  options.modules.wireshark.enable = lib.mkEnableOption "Enable wireshark";

  config = lib.mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };
    users.users.jeroen.extraGroups = [ "wireshark" ];
  };
}
