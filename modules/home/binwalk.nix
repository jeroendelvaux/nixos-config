{ config, lib, pkgs, secrets, ... }:

let
  cfg = config.modules.binwalk;
in
{
  options.modules.binwalk.enable = lib.mkEnableOption "Enable binwalk";

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.binwalk
    ];
  };
}
