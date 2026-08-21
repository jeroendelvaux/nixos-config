{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.libreoffice;
in
{
  options.libreoffice.enable = lib.mkEnableOption "Enable LibreOffice";

  config.home.packages = lib.mkIf cfg.enable (with pkgs; [
    libreoffice-still
  ]);

  config.home.sessionVariables = lib.mkIf cfg.enable {
    SAL_USE_VCLPLUGIN = "gtk3";
  };
}
