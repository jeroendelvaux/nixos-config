{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.btop;
in
{
  options.modules.home.btop.enable = lib.mkEnableOption "btop";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.btop
    ];
  };
}
