{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.nmap;
in
{
  options.modules.nmap.enable = lib.mkEnableOption "Enable nmap";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nmap
    ];
  };
}
