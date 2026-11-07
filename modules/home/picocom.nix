{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.picocom;
in
{
  options.modules.home.picocom.enable = lib.mkEnableOption "picocom";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.picocom
    ];
  };
}
