{ config, lib, pkgs, secrets, ... }:

{
  options.libreoffice.enable = lib.mkEnableOption "Enable LibreOffice";

  config = lib.mkIf config.libreoffice.enable {
    home.packages = with pkgs; [
      libreoffice-still
    ];
    home.sessionVariables = {
      SAL_USE_VCLPLUGIN = "gtk3";
    };
  };
}
