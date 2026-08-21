{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.gtk3;
in
{
  options.gtk3.enable = lib.mkEnableOption "Enable gtk3";

  config.gtk = lib.mkIf cfg.enable {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };
}
