{ config, lib, pkgs, secrets, ... }:

{
  options.gtk3.enable = lib.mkEnableOption "Enable gtk3";

  config = lib.mkIf config.gtk3.enable {
    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    };
  };
}
