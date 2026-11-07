{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.nmap;
in
{
  options.modules.home.nmap.enable = lib.mkEnableOption "nmap";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nmap
    ];
  };
}
