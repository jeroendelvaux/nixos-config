{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.gtk3;
in
{
  options.modules.gtk3.enable = lib.mkEnableOption "Enable gtk3";

  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
  };
}
