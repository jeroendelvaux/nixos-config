{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.traceroute;
in
{
  options.modules.traceroute.enable = lib.mkEnableOption "Enable traceroute";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.traceroute
    ];
  };
}
