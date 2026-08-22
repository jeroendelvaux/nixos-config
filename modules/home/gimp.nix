{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.gimp;
in
{
  options.modules.gimp.enable = lib.mkEnableOption "Enable gimp";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.gimp
    ];
  };
}
