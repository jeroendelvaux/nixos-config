{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.btop;
in
{
  options.modules.btop.enable = lib.mkEnableOption "Enable btop";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.btop
    ];
  };
}
