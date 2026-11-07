{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.gdb;
in
{
  options.modules.home.gdb.enable = lib.mkEnableOption "GDB";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gdb
    ];
  };
}
