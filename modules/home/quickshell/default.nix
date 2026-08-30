{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.quickshell;
in
{
  options.modules.quickshell.enable = lib.mkEnableOption "Enable quickshell";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.quickshell
    ];
    xdg.configFile."quickshell" = {
      source = ./qml;
      recursive = true;
    };
  };
}
