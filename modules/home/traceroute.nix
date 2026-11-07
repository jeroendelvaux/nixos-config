{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.traceroute;
in
{
  options.modules.home.traceroute.enable = lib.mkEnableOption "traceroute";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.traceroute
    ];
  };
}
