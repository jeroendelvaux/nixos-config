{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.ascii;
in
{
  options.modules.ascii.enable = lib.mkEnableOption "Enable ascii";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.ascii
    ];
  };
}
