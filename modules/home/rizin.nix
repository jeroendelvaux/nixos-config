{ config, lib, pkgs, ... }:

let
  cfg = config.modules.home.rizin;
in
{
  options.modules.home.rizin.enable = lib.mkEnableOption "rizin";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.rizin
    ];
  };
}
