{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.gdb;
in
{
  options.modules.gdb.enable = lib.mkEnableOption "Enable gdb";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gdb
    ];
  };
}
