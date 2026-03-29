{ config, pkgs, pkgs-unstable, ... }:

{
  xdg.portal = {
    enable = true;
    wlr.enable = true; # screenshots and screencasts
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };
}