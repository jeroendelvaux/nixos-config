{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.hexedit;
in
{
  options.modules.home.hexedit.enable = lib.mkEnableOption "hexedit";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hexedit
    ];
  };
}
