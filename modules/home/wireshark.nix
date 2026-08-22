{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.wireshark;
in
{
  options.modules.wireshark.enable = lib.mkEnableOption "Enable wireshark";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.wireshark
    ];
  };
}
