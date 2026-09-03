{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.qt;
in
{
  options.modules.qt.enable = lib.mkEnableOption "Enable qt";

  config = lib.mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style = {
        name = "adwaita";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
