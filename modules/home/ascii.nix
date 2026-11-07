{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.ascii;
in
{
  options.modules.home.ascii.enable = lib.mkEnableOption "ascii";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.ascii
    ];
  };
}
