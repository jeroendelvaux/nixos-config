{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.traceroute;
in
{
  options.traceroute.enable = lib.mkEnableOption "Enable traceroute";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    traceroute
  ]);
}
