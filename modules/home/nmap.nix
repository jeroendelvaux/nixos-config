{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.nmap;
in
{
  options.nmap.enable = lib.mkEnableOption "Enable nmap";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    nmap
  ]);
}
