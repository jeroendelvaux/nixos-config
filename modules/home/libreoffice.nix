{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.libreoffice;
in
{
  options.modules.libreoffice.enable = lib.mkEnableOption "Enable LibreOffice";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.libreoffice-still
    ];
    home.sessionVariables = {
      SAL_USE_VCLPLUGIN = "gtk3";
    };
  };
}
