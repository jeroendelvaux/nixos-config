{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.libreoffice;
in
{
  options.modules.home.libreoffice.enable = lib.mkEnableOption "LibreOffice";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.libreoffice-still
    ];
    home.sessionVariables = {
      SAL_USE_VCLPLUGIN = "gtk3";
    };
  };
}
