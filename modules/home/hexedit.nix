{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.hexedit;
in
{
  options.modules.hexedit.enable = lib.mkEnableOption "Enable hexedit";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hexedit
    ];
  };
}
