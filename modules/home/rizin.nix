{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.rizin;
in
{
  options.modules.rizin.enable = lib.mkEnableOption "Enable rizin";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.rizin
    ];
  };
}
