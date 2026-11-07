{ config, lib, pkgs, ... }:

let
  cfg = config.modules.nixos.xdg;
in
{
  options.modules.nixos.xdg = {
    enable = lib.mkEnableOption "xdg";
  };

  config = lib.mkIf cfg.enable {
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        xdg-desktop-portal-gtk
      ];
      config.common = {
        default = [ "gtk" "gnome" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.AppChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Settings" = [ "gnome" "gtk" ];
      };
    };
  };
}
