{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.gdb;
in
{
  options.gdb.enable = lib.mkEnableOption "Enable gdb";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    gdb
  ]);
}
