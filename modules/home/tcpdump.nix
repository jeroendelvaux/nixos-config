{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.tcpdump;
in
{
  options.tcpdump.enable = lib.mkEnableOption "Enable tcpdump";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    tcpdump
  ]);
}
