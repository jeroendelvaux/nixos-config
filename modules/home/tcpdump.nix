{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.tcpdump;
in
{
  options.modules.home.tcpdump.enable = lib.mkEnableOption "tcpdump";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.tcpdump
    ];
  };
}
