{ config, lib, pkgs, secrets, ... }:

{
  options.gdb.enable = lib.mkEnableOption "Enable gdb";

  config = lib.mkIf config.gdb.enable {
    home.packages = with pkgs; [
      gdb
    ];
  };
}
