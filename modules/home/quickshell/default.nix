{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.quickshell;
in
{
  options.modules.home.quickshell.enable = lib.mkEnableOption "quickshell";

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
