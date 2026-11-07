{ config, lib, ... }:

let
  cfg = config.modules.home.qt;
in
{
  options.modules.home.qt.enable = lib.mkEnableOption "QT";

  config = lib.mkIf cfg.enable {
    qt = {
      enable = true;
    };
  };
}
