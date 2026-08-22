{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.checksec;
in
{
  options.modules.checksec.enable = lib.mkEnableOption "Enable checksec";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.checksec
    ];
  };
}
